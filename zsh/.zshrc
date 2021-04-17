export EDITOR="vim"
export DOTFILES=$HOME/.dotfiles/zsh

# Modules
[[ -f $DOTFILES/modules/init.zsh ]] && source $DOTFILES/modules/init.zsh

[[ -f $DOTFILES/modules/fzf.zsh ]] && source $DOTFILES/modules/fzf.zsh
[[ -f $DOTFILES/modules/asdf.zsh ]] && source $DOTFILES/modules/asdf.zsh
[[ -r "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc" ]] && source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"
[[ -f $DOTFILES/modules/pnpm.zsh ]] && source $DOTFILES/modules/pnpm.zsh
[[ -f $DOTFILES/modules/git.zsh ]] && source $DOTFILES/modules/git.zsh
[[ -f $DOTFILES/modules/rails.zsh ]] && source $DOTFILES/modules/rails.zsh
[[ -f $DOTFILES/modules/bundler.zsh ]] && source $DOTFILES/modules/bundler.zsh

[[ -f $DOTFILES/modules/aliases.zsh ]] && source $DOTFILES/modules/aliases.zsh
[[ -f $DOTFILES/modules/functions.zsh ]] && source $DOTFILES/modules/functions.zsh

# Prompt
if (( $+commands[starship] ))
then
  eval "$(starship init zsh)"
fi
