#------PACMAN------#
alias build='pacman -U'
alias remove='sudo pacman -Rns'
alias update='sudo pacman -Syu && /home/n0ko/programming/lua_projects//gitup.lua ~/Programs/'
alias build='sudo pacman -U'
alias orphan='sudo pacman -Qtdq | pacman -Rns -'
alias search='sudo pacman -Q'
alias pacclean='sudo pacman -Q'
alias mirrorlist='sudo nvim /etc/pacman.d/mirrorlist'

#-------YAY-------#
alias yupdate='sudo yay -Syu'
alias yadd='yay -S'
alias yremove='yay -Rns'


#------FUNCTIONS------#
function rollback(){sudo pacman -U $1}
function rev(){
    c /var/cache/pacman/pkg/ 
}

add() {
	sudo pacman -S $@
}
