apps () {
	pushd ~/codebase/
	nvim $(fd -tf --full-path ~/codebase/ | fzf --layout reverse --border --border-label='Codebase' --previekeybindsw 'bat --style=numbers --color=always --line-range :500 {}')
}

config () {
	pushd ~/.config
	nvim $(fd -tf -H | fzf --layout reverse --border --border-label='Configurations' --preview 'bat --style=numbers --color=always --line-range :500 {}')
}


exconf () {
	nvim ~/.zsh/exports/$(cd ~/.zsh/exports && fd -tf |\
        fzf --layout reverse --border --border-label='Export Configurations' --preview 'bat --style=numbers --color=always --line-range :500 {}')
}


luap () {
	pushd /home/n0ko/programming/lua_projects/
	nvim $(fd -e lua | flist 'Lua Programs')
}


rag() { /rag        [1/4]
    zellij run --floating --close-on-exit -- rag.lua
}


plug () {
	pushd ~/.local/share/nvim/lazy/ && c $(fd -td -d1 |fzf --layout reverse --border --border-label='Neovim Plugins' --preview 'bat --style=numbers --color=always --line-range :500 {}')
}

program () {
	pushd ~/Programs
	cd $(fd -td -d1 | fzf --layout reverse --border --border-label='Programs' --preview 'bat --style=numbers --color=always --line-range :500 {}')

	CURSOR=$#BUFFER 
	zle accept-line 2> /dev/null
}

rusty () {
	pushd ~/programming/rusticean
	nvim $(fd -e rs | flist "RUSTY")
}

spell () {
	pushd ~/scripts
	nvim $(fd -tf | flist 'Spells')
}

vconf () {
	pushd ~/.config/nvim
	nvim $(fd -e lua | flist 'Neovim Configurations')
}

zconf () {
	nvim ~/.zsh/tooling/$(cd ~/.zsh/tooling && fd -tf |\
        fzf --layout reverse --border --border-label='Zsh Configurations' --preview 'bat --style=numbers --color=always --line-range :500 {}')
}

function leader_key() {
    local key
    read -sk 1 key
    case $key in
        (c) config ;;
        (x) exconf ;;
        (l) luap ;;
        (p) plug ;;
        (o) program ;;
        (r) rag ;;
        (y) rusty ;;
        (s) spell ;;
        (v) vconf ;;
        (z) zconf
    esac
}
#zle -N apps
zle -N leader_key

bindkey '^X' leader_key
