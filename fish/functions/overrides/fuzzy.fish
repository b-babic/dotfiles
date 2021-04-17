# FZF
set -gx FZF_DEFAULT_COMMAND "rg --files --no-require-git --column --line-number --no-heading --color=always --smart-case"
set -gx FZF_DEFAULT_OPTS "$FZF_MOVEMENT \
    --color='light'
    --bind='ctrl-p:toggle-preview' \
    --preview-window 'right:100:wrap:cycle' \
    --preview 'bat --color=always {} 2>/dev/null || cat {}'
    --height=80% \
    --info='inline' \
    --exact \
    --cycle \
    --reverse \
    --ansi"
