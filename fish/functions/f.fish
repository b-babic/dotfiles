function __fzf_files
	# Override default $FZF_DEFAULT_OPTS here
	fzf \
	--header "<C-s> to open in Sublime, <C-v> to open in vim, <C-c> to open in code, <C-y> to copy path" \
	--info "hidden" \
	--bind "ctrl-s:execute-silent(subl {})+abort" \
	--bind "ctrl-v:execute(nvim {})+abort" \
	--bind "enter:execute(nvim {})+abort" \
	--bind "ctrl-c:execute-silent(code {})+abort" \
	--bind "ctrl-y:execute(echo {} | pbcopy)+abort" \
	--margin "5%,0%"
end

function f --description "Run interactive fzf finder"
	if count $argv >/dev/null
		rg -l $argv | __fzf_files
	else
		rg . -l | __fzf_files
	end
end
