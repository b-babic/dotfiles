#!/bin/zsh

pomodoro_time=900 # seconds
cooldown_time=20  # seconds

start_pomodoro() {
  local pomodoro_time=$1
  echo "Pomodoro timer started with a duration of ${pomodoro_time} seconds"

  for ((i=pomodoro_time; i>0; i--)); do
    echo "$((i / 60)) minutes, $((i % 60)) seconds remaining"
    sleep 1
  done
}

send_notification() {
  local title="$1"
  local message="$2"
  local soundName="$3"
  local subtitle="$4"

  terminal-notifier -message="$message" \
                    -title="$title" \
                    -soundName="$soundName" \
                    -subtitle="$subtitle"
}

start_cooldown() {
  sleep $1
}

main() {
  # Start the pomodoro timer with default arguments
  start_pomodoro $1

  # Send notification for the first time
  send_notification "Pomodoro timer has ended" \
                    "Time to take a break!" \
                    "Bell.aiff" \
                    "Time to take a break!"

  # Start the cooldown timer and send another notification after 20 seconds
  start_cooldown $cooldown_time

  # Check if the timer was interrupted during the cooldown period and start it again if it wasn't
  if [[ ! $interrupted ]]; then
    echo "Starting pomodoro timer again..."
    main "$@"
  fi
}

# Run
main $1
