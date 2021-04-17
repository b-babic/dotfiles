if [ -n "$ZSH_VERSION" ]; then
  autoload -U bashcompinit
  bashcompinit
fi

if [ "$(uname 2> /dev/null)" != "Linux" ]; then
  source $HOME/.asdf/asdf.sh
  source $HOME/.asdf/completions/asdf.bash
fi
