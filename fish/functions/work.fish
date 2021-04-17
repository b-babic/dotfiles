function work --description "Create tmux sessions for the work profile"
    set -l __status $status

    # TODO: Move manual session creation to a something more pretty
    # Create default sessions for the most common projects
    cd /Users/ben/Work/seenons-fe-library
    ts lib
    cd /Users/ben/Work/seenons-fe-logistics
    ts logistics
    cd /Users/ben/Work/seenons-fe-logistics-orders
    ts orders
    cd /Users/ben/Work/seenons-x-emails
    ts emails

    cd /Users/ben/Work

    # Attach orders as a default session
    ta orders

    if test $__status = 0
        set -l __info "Something wen't wrong while creating tmux sessions!"
        printf '[%s%s%s]' (set_color red) $__info (set_color normal)
    end
end
