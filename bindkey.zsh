apps () {
	pushd ~/codebase/
  nvim $(fd -tf --full-path ~/codebase/ | flist 'Codebase')
}

rag() { /rag        [1/4]
    zellij run --floating --close-on-exit -- rag.lua
}

#PROGRAMMING KEYS
program () {
	pushd ~/Programs
	cd $(fd -td -d1 | flist )


	CURSOR=$#BUFFER 
	zle accept-line 2> /dev/null
}

luap () {
	pushd /home/n0ko/programming/lua_projects/
	nvim $(fd -e lua | flist 'Lua Programs')
}

pyap () {
	pushd /home/n0ko/programming/python_projects/
	nvim $(fd -e py | flist 'Python Programs')
}

rusty () {
	pushd ~/programming/rust_projects/
	nvim $(fd -e rs | flist "Rust Programs")
}

spell () {
  pushd ~/scripts/
	nvim $(fd -tf | flist "Spells")
}

stats () {
  pushd ~/stats/
	nvim $(fd -tf | flist "Statistics")
}

#CONFIG_KEYS
config () {
	pushd ~/.config
	nvim $(fd -tf -H | flist 'Configurations')
}

exconf () {
	nvim ~/.zsh/exports/$(cd ~/.zsh/exports && fd -tf | flist 'Export Configurations')
}

plug () {
	pushd ~/.local/share/nvim/lazy/ && c $(fd -td -d1 |flist 'Neovim Plugins')
}

vconf () {
	pushd ~/.config/nvim
	nvim $(fd -e lua | flist 'Neovim Configurations')
}

zconf () {
	nvim ~/.zsh/tooling/$(cd ~/.zsh/tooling && fd -tf |\
        flist )
}

#SSH KEYS
m1_ssh() {
    zellij run --floating --close-on-exit -- ssh n0ko@m1
}

charlie_ssh() {
    zellij run --floating --close-on-exit -- ssh n0ko@charlie
}

function leader_programming() {
    local key
    read -sk 1 key
    case $key in
        (p) pyap ;;
        (l) luap ;;
        (r) rusty ;;
        (s) spell ;;
        (t) stats ;;
    esac
}

function leader_ssh() {
    local key
    read -sk 1 key
    case $key in
        (m) m1_ssh ;;
        (c) charlie_ssh ;;
    esac
}

function leader_config() {
    local key
    read -sk 1 key
    case $key in
        (x) exconf ;;
        (c) config ;;
        (p) plug ;;
        (v) vconf ;;
        (z) zconf ;;
    esac
}

function leader_key() {
    local key
    read -sk 1 key
    case $key in
        (c) leader_config ;;
        (p) leader_programming ;;
        (r) rag ;;
        (s) leader_ssh;;
        (o) program ;;
    esac
}

zle -N leader_key

bindkey '^@' leader_key
