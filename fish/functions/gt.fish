function gt --description "Show git tags sorted by recent creation date"
	set -l __status $status

	git \
	for-each-ref \
	--sort=creatordate \
	--format='%(creatordate:short)_,,,_%(refname:strip=2)_,,,_%(subject)' \
	refs/tags \ |
	grep $argv \ |
	awk 'BEGIN { FS = "_,,,_"  } ; { printf "%-20s %-40s %-60s \n", $1, $2, $3 }'

	if test $__status = 0
		set -l __info "No tags available for this repository yet."
		printf '[%s%s%s]' (set_color blue) $__info (set_color normal)
	end
end
