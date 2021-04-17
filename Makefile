all: sync

sync:
	mkdir -p ~/.config/fish
	mkdir -p ~/.config/nvim
	mkdir -p ~/.config/ghostty

	[ -f ~/.config/fish/config.fish ] || ln -s $(PWD)/fish/config.fish ~/.config/fish/config.fish
	[ -d ~/.config/fish/functions/ ] || ln -s $(PWD)/fish/functions ~/.config/fish/functions
	[ -f ~/.vimrc ] || ln -s $(PWD)/vim/.vimrc ~/.vimrc
	[ -f ~/.config/nvim/init.lua ] || ln -s $(PWD)/nvim/init.lua ~/.config/nvim/init.lua
	[ -f ~/.config/nvim/src/settings.lua ] || ln -s $(PWD)/nvim/src ~/.config/nvim/src
	[ -f ~/.tigrc ] || ln -s $(PWD)/tig/.tigrc ~/.tigrc
	[ -f ~/.gitconfig ] || ln -s $(PWD)/git/.gitconfig ~/.gitconfig
	[ -f ~/.agignore ] || ln -s $(PWD)/ag/.agignore ~/.agignore
	[ -f ~/.config/ghostty/config ] || ln -s $(PWD)/ghostty/config ~/.config/ghostty/config

	# [ -f ~/.config/zed/settings.json ] || ln -s $(PWD)/zed-config.json ~/.config/zed/settings.json
	# [ -f ~/.config/zed/keymap.json ] || ln -s $(PWD)/zed-keymap.json ~/.config/zed/keymap.json
	# [ -f ~/.config/zed/tasks.json ] || ln -s $(PWD)/zed-tasks.json ~/.config/zed/tasks.json

	# don't show last login message
	touch ~/.hushlogin

clean:
	rm -f ~/.vimrc
	rm -f ~/.config/nvim/init.lua
	rm -f ~/.config/fish/config.fish
	rm -rf ~/.config/fish/functions/
	rm -f ~/.tigrc
	rm -f ~/.gitconfig
	rm -f ~/.agignore
	rm -f ~/.config/ghostty/config
	rm -f ~/.config/zed/settings.json
	rm -f ~/.config/zed/keymap.json
	rm -f ~/.config/zed/tasks.json

.PHONY: all clean sync
