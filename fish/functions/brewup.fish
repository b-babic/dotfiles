function brewup --description "Cleans up brew packages"
  set -l __status $status

  brew update
  brew upgrade
  brew cleanup
  brew doctor

  if test $__status = 0
		set -l __info "Brew cleanup finished successfully"
		printf '[%s%s%s]' (set_color green) $__info (set_color normal)
	end
end
