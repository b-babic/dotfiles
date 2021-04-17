function twork --description "Create pomodoro work session"
    set -l __work_time $argv[1]

    if test -z $__work_time
        set -l __work_time 60m
    end

    timer $__work_time && terminal-notifier -message 'Pomodoro'\
        -title 'Work Timer is up! Take a Break 😊'\
        -appIcon '~/Pictures/pumpkin.png'\
        -sound Crystal
end
