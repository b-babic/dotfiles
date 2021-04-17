function stream-youtube --description "Stream youtube video using quicktime player"
	set -l __status $status

	if not set -q argv[1]
		set -l __info "URL is required."
		printf '[%s%s%s]' (set_color red) $__info (set_color normal)
	end

	streamlink \
	--player="/Applications/IINA.app/Contents/MacOS/IINA" \
	--player-args="--stdin" \
	$argv[1] \
	$argv[2]

	if test $__status = 0
		set -l __info "Please try again!"
		printf '[%s%s%s]' (set_color blue) $__info (set_color normal)
	end
end
