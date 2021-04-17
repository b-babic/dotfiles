function stream-twitch --description "Stream twitch video using quicktime player"
	set -l __status $status

	if not set -q argv[1]
		set -l __info "URL is required."
		printf '[%s%s%s]' (set_color red) $__info (set_color normal)
	end

	streamlink \
	--twitch-disable-ads \
  --player="/usr/bin/open" \
  --player-args="-W -n -a 'Quicktime Player' {filename}" \
  --player-passthrough="hls" \
	$argv[1] \
	$argv[2]

	if test $__status = 0
		set -l __info "Please try again!"
		printf '[%s%s%s]' (set_color blue) $__info (set_color normal)
	end
end
