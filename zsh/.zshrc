# ~/.zshrc

# Core settings
export EDITOR="vim"
export DOTFILES="$HOME/.dotfiles/zsh"
export OS_TYPE="$(uname -s | tr '[:upper:]' '[:lower:]')"

# Debug mode (usage: ZSH_DEBUG=1 zsh)
ZSH_DEBUG=${ZSH_DEBUG:-0}

# Utility functions
debug() {
    [[ $ZSH_DEBUG -eq 1 ]] && echo "[DEBUG] $@"
}

source_if_exists() {
    [[ -f "$1" ]] && { debug "Sourcing: $1"; source "$1"; return 0; }
    debug "File not found: $1"
    return 1
}

# Define core modules that should be loaded first
CORE_MODULES=(init path)

# Define module dependencies
typeset -A MODULE_DEPS
MODULE_DEPS=(
    ["git"]="fzf"
    ["rails"]="bundler"
    ["aliases"]="fzf git"
)

# Track loaded and failed modules
typeset -a LOADED_MODULES FAILED_MODULES

load_module() {
    local module="$1"
    debug "Loading module: $module"

    # Skip if already loaded
    (( ${LOADED_MODULES[(I)$module]} )) && return 0

    # Load dependencies first
    if [[ -n "${MODULE_DEPS[$module]}" ]]; then
        for dep in ${=MODULE_DEPS[$module]}; do
            load_module "$dep" || {
                FAILED_MODULES+=("$module (dependency: $dep failed)")
                return 1
            }
        done
    fi

    # Try to load OS-specific version first, then fall back to generic
    if source_if_exists "$DOTFILES/modules/$OS_TYPE/${module}.zsh" || \
       source_if_exists "$DOTFILES/modules/common/${module}.zsh"; then
        LOADED_MODULES+=("$module")
        return 0
    fi

    FAILED_MODULES+=("$module")
    return 1
}

# Function to load all modules
load_modules() {
    # Load core modules first
    for module in $CORE_MODULES; do
        load_module "$module"
    done

    # Get list of all available modules
    local os_modules=()
    local common_modules=()

    # Collect OS-specific modules
    if [[ -d "$DOTFILES/modules/$OS_TYPE" ]]; then
        os_modules=($(/bin/ls -1 "$DOTFILES/modules/$OS_TYPE" | grep '\.zsh$' | sed 's/\.zsh$//' | sort -u))
    fi

    # Collect common modules
    if [[ -d "$DOTFILES/modules/common" ]]; then
        common_modules=($(/bin/ls -1 "$DOTFILES/modules/common" | grep '\.zsh$' | sed 's/\.zsh$//' | sort -u))
    fi

    # Combine and deduplicate module lists
    local modules=(${(u)os_modules} ${(u)common_modules})

    # Load all non-core modules
    for module in $modules; do
        [[ " $CORE_MODULES " == *" $module "* ]] && continue
        load_module "$module"
    done

    # Report failures
    if (( $#FAILED_MODULES > 0 )); then
        echo "Failed to load modules:"
        printf '%s\n' "${FAILED_MODULES[@]}"
    fi
}

# Module management command
zsh_module() {
    case "$1" in
        list)
            echo "Loaded modules:"
            printf '%s\n' "${LOADED_MODULES[@]}"
            [[ ${#FAILED_MODULES[@]} -gt 0 ]] && {
                echo "\nFailed modules:"
                printf '%s\n' "${FAILED_MODULES[@]}"
            }
            ;;
        reload)
            [[ -z "$2" ]] && { echo "Module name required"; return 1; }
            LOADED_MODULES=("${LOADED_MODULES[@]:#$2}")
            load_module "$2" && echo "Reloaded module: $2"
            ;;
        deps)
            [[ -n "$2" ]] && {
                echo "Dependencies for $2: ${MODULE_DEPS[$2]:-none}"
                return
            }
            echo "Module dependencies:"
            for module deps in ${(kv)MODULE_DEPS}; do
                echo "$module: ${deps:-none}"
            done
            ;;
        *)
            echo "Usage: zsh_module <list|reload|deps> [module]"
            ;;
    esac
}

# Initialize modules
load_modules

# Load prompt last (if using starship)
(( $+commands[starship] )) && eval "$(starship init zsh)"
