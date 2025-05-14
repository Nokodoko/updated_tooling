#------Aliases------#
source /usr/share/fzf/completion.zsh
#alias fc='fc-cache -f -v'
#alias zip='tar -xf'
alias Q='cd ..'
alias ac='arp -a'
alias ai='sgpt'
alias ar='arandr'
alias as='arp-scan --localnet'
alias btar='bsdtar -xpf'
alias cal='calcurse'
alias cat='bat'
alias clock='tty-clock -cs -C 4'
alias count='wc -l'
alias dmenu='dmenu -m 0 -fn VictorMono:size=20 -nf green -nb black -nf green -sb black'
alias doc='c ~/Documents'
alias drc='nvim ~/.config/dunst/dunstrc'
alias e='exit'
alias evil='airmon-ng start wlp5s0mon'
alias evilt='airmon-ng --test wlp5s0mon'
alias ex='export'
alias gback='sudo downgrade glib2=2.74.6'
alias gp='rg'
alias gr='geo-recon.py'
alias gscan='sudo goscan'
alias ipe='ip netns exec'
alias k='kubectl'
alias lj='v ~/.config/lynx/jumpsUnix.html'
alias lt='litecli'
alias lx='v ~/.config/lynx/lynx.cfg'
alias ly='lynx -cfg=/home/n0ko/.config/lynx/lynx.cfg'
alias mail='neomutt'
alias md='mkdir'
alias mp='mplayer'
alias ns='notify-send'
alias pb='~/.config/polybar/colorblocks/launch.sh'
alias pm='pulsemixer'
alias poly='polybar'
alias pup='pup -c'
alias sl='c ~/n0koSuckless/slstatus'
alias socket='zmodload zsh/net/tcp'
alias top='bptop'
alias v='nvim'
alias vb='nvim ~/.zshenv'
alias vbox='virtualbox'
alias vr='virsh'
alias w='which'
alias y='ytfzf -t'
alias yv='youtube-viewer'
alias crkbd='sudo kmonad ~/.config/kmonad/crkbd.kbd & disown'

#-----PROGRAMS-----#

alias vpn='openvpn3 session-start --background --config ~/.pass/client.ovpn'
alias vpns='openvpn3 sessions-list'


#-----BUILD TOOLS-----#
alias makeit='makepkg -si'
alias smci='sudo make clean install -j$(nproc)'

#------FUNCTION------#
function c(){
    cd $1 
    nvim $(lister.sh)
    #colorls --git-status
}

function man() {
  /usr/bin/man $* | \
    col -b | \
    nvim -R -c 'set ft=man nomod nolist' -
}
#man $(command man -k .  | gum filter | awk '{print $1, $2}')

function mkc(){
    mkdir -p $1
    cd $1
}

function nsx(){
    nsxiv $@ &
    disown nsxiv
} 

function mkn(){
    mknod /dev/$1 $2 $3 $4
    cd $1
}

function sb(){
    cat ~/.zshenv > ~/.zsh/tooling/zshenv
    source ~/.zshenv
}

function wallpaper() {
    feh --bg-scale $1
}

function vf() {
    v $(flist $( basename $( pwd )))
}

function svf() {
    sudo nvim $(flist $( basename $( pwd )))
}

function cfd() {
    c $(fd -td $1)
}

function path () {
  echo -e ${PATH//:/\\n}
}
