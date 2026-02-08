#------PACMAN------#
alias build='sudo pacman -U'
alias remove='sudo pacman -Rns'
alias orphan='sudo pacman -Qtdq | sudo pacman -Rns -'
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

function add(){
	sudo pacman -S "$@"
}

# Safe system update that tracks kernel version changes
function update(){
	# Capture current kernel version before update
	local old_kernel=$(pacman -Q linux 2>/dev/null | awk '{print $2}')

	# Run system update
	sudo pacman -Syu
	local pacman_exit=$?

	# If pacman succeeded, run gitup script
	if [[ $pacman_exit -eq 0 ]]; then
		/home/n0ko/programming/lua_projects/gitup.lua ~/Programs/
	else
		return $pacman_exit
	fi

	# Check if kernel version changed
	local new_kernel=$(pacman -Q linux 2>/dev/null | awk '{print $2}')

	if [[ -n "$old_kernel" && -n "$new_kernel" && "$old_kernel" != "$new_kernel" ]]; then
		# Kernel was updated - warn and prompt
		echo ""
		echo "\033[1;33m===> Stock kernel updated: $old_kernel → $new_kernel\033[0m"
		echo "\033[1;33m===> Lightweight kernel may need updating\033[0m"
		echo ""
		echo "Run update script now? [y/N]"
		read -q response
		echo ""

		if [[ "$response" == "y" ]]; then
			~/lightweight-kernel/update-kernel.sh
		else
			echo "\033[0;36mReminder: ~/lightweight-kernel/update-kernel.sh\033[0m"
		fi
	fi
}
