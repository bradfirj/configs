# Applications
export PAGER='vimpager'
export EDITOR='vim'
export BROWSER='fx'

# History control
export HISTCONTROL="ignoreboth"
export HISTFILESIZE=500000

# Prompt
export PS1="\[\e[1;35m\]\w \[\e[1;37m\]\$ \[\e[0;37m\]"

# Options
shopt -s autocd cdspell
shopt -s dirspell extglob
shopt -s cmdhist nocaseglob

# Walk through completions with ^T
bind "\\C-t: menu-complete"

# Clear screen with ^L
bind "\\C-l: clear-screen"

# Remove annoying fc map
bind -m vi -r v

# Load autojump
. /etc/profile.d/autojump.bash

# Aliases
# Ls
alias ls='ls --color=auto -Fh --group-directories-first'
alias ll='ls -lah'
alias no='ls'
alias na='ll'

# Abbreviations
alias i='makepkg -fi'
alias a='git add'
alias d='git diff'
alias p='git push origin master'
alias pu='git pull origin master'

alias v='vim'
alias vv='sudo vim'

# Shortcuts
alias aur='slurpy -c -t ~/sources/ -f'
alias slide='qiv -usrtm -d 7 -B '
alias vg='viewglob -t off -s windows'

# Tofu organiser shortcuts
orgn(){ tofu org next feed="$1"${@#$1} && tofu org; }
org(){ tofu org $@; }
miscn(){ tofu misc next feed="$1"${@#$1} && tofu misc; }
misc(){ tofu misc $@; }
projn(){ tofu proj next feed="$1"${@#$1} && tofu proj; }
proj(){ tofu proj $@; }
todosync(){ unison ~/.tofu ssh://root@glacicle.org//root/todo; }

# Shortcut functions
x(){ cd ~; xinit $@; }

# Daemon shortcuts
dr(){ sudo /etc/rc.d/$1 restart; }
ds(){ sudo /etc/rc.d/$1 start; }
dt(){ sudo /etc/rc.d/$1 stop; }

# Load/reload keymap function
hdv() {
    setxkbmap -I$HOME/.xkb -model evdev -layout hdv -print | \
        grep -v '^Could' | grep -v '^Use' | \
        xkbcomp -I$HOME/.xkb - :0 &> /dev/null

    xmodmap -e "remove mod4 = Alt_L" &
}

# Commit git -a or path
c (){
    [[ $@ ]] && git commit $@ || git commit -a
}

# Download package from abs
absdown (){
    abs $1/$2
    cp -R /var/abs/$1/$2 ~/sources/
    cd ~/sources/$2
}

# Flatten function
flat (){
    mkdir ../__flat;
    find . -print0 | xargs -0 -i'{}' cp '{}' ../__flat;
    mv ../__flat/* . && rmdir ../__flat
}
