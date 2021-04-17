if [ -n "$ZSH_VERSION" ]; then
  autoload -U bashcompinit
  bashcompinit
fi

if [ "$(uname 2> /dev/null)" != "Linux" ]; then
    eval "$(~/.local/bin/mise activate zsh)"
fi
