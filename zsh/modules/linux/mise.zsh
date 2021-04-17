if command -v mise >/dev/null; then
    eval "$(mise activate zsh)"

    # mise aliases
    alias mr='mise runtime'
    alias mi='mise install'
    alias mu='mise use'
    alias ml='mise latest'
fi
