function scripts --description "Show all available user scripts from scripts/ folder"
	fd . /Users/ben/scripts | \
	fzf \
	--header '<Ctrl-e> to open scripts/ in $EDITOR, <Enter> to edit script' \
	--bind 'ctrl-e:execute(nvim /Users/ben/scripts {})+abort' \
	--bind 'enter:execute(nvim {})+abort' \
	--preview 'bat --color=always --line-range=:500 {} 2>/dev/null || cat {}'
end
