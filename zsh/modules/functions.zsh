timeshell() {
    for i in $(seq 1 10); do /usr/bin/time $SHELL -i -c exit; done
}

c() { cd ~/code/$1; }
_c() { _files -W ~/code -/; }
compdef _c c

h() { cd ~/$1; }
_h() { _files -W ~/ -/; }
compdef _h h

# autocorrect is more annoying than helpful
unsetopt correct_all

# Pomodoro timer
pom() { ~/.dotfiles/zsh/modules/timer.zsh "$@" }
