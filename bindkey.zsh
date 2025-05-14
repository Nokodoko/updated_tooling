apps () {
	pushd ~/codebase/
  nvim $(fd -tf --full-path ~/codebase/ | flist 'Codebase')
}

aws_jump () {
	pushd ~/Portfolio/aws/
  nvim $(fd -tf  | flist 'n0ko AWS Terraform')
}

rag() { #rag        [1/4]
    zellij run --floating --close-on-exit -- rag.lua
}

wall() { #wallpaper
    zellij run --floating --close-on-exit -- ~/scripts/wall.zsh
}

nvim_update() { #wallpaper
    zellij run --floating --close-on-exit -- ~/scripts/nvim_update.py
}
#PROGRAMMING KEYS
program () {
	pushd ~/Programs
	cd $(fd -td -d1 | flist )


	CURSOR=$#BUFFER 
	zle accept-line 2> /dev/null
}

codebase2 () {
	pushd /home/n0ko/codebase2/
	nvim $(fd -tf | flist 'codebase2')
}

codebase () {
	pushd /home/n0ko/codebase/
	nvim $(fd -tf | flist 'codebase')
}

luap () {
	pushd /home/n0ko/programming/lua_projects/
	nvim $(fd -e lua | flist 'Lua Programs')
}

pyap () {
	pushd /home/n0ko/programming/python_projects/
	nvim $(fd -e py | flist 'Python Programs')
}

goap () {
	pushd /home/n0ko/programming/go_projects/
	nvim $(fd -e go | flist 'Go Programs')
}

ddog_server () {
	pushd /home/n0ko/Portfolio/mkii_ddog_server/
	nvim $(fd -e go | flist "n0ko's Datadog Server")
}

dogap () {
	pushd /home/n0ko/Portfolio/ddog_webhooks_terraform/downtimes/ddog-services-backend/go_downtimes/
	nvim $(fd -e go | flist 'Datadog Program')
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
	nvim ~/.zsh/exports/$(cd ~/.zsh/exports && fd -tf | flist 'Export Coneigurations')
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

forest_scripts () {
	nvim ~/forest/scripts/$(cd ~/forest/scripts/ && fd -tf |\
        flist 'Forest Scripts')
}

echo_scripts () {
	nvim ~/forest/scripts/$(cd ~/forest/scripts/ && fd -tf |\
        flist 'Ecco Scripts')
}

gup () {
  zellij run --floating -- gitup.lua ~/Programs/
}

#SSH KEYS
m1_ssh() {
    zellij run --floating --close-on-exit -- ssh n0ko@m1
}

command_ssh() {
    zellij run --floating --close-on-exit -- ssh n0ko@command
}

function leader_programming() {
    local key
    read -sk 1 key
    case $key in
        (a) aws_jump ;;
        (p) pyap ;;
        (g) goap ;;
        (l) luap ;;
        (d) dogap ;;
        (r) rusty ;;
        (s) spell ;;
        (t) stats ;;
        (f) forest_scripts ;;
    esac
}

function leader_ssh() {
    local key
    read -sk 1 key
    case $key in
        (m) m1_ssh ;;
        (c) command_ssh ;;
    esac
}

function datadog() {
    local key
    read -sk 1 key
    case $key in
        (s) ddog_server ;;
    esac
}

function zellagio() {
    local key
    read -sk 1 key
    case $key in
        (a) za ;;
    esac
}

function leader_config() {
    local key
    read -sk 1 key
    case $key in
        (a) codebase ;;
        (c) config ;;
        (p) plug ;;
        (s) codebase2 ;;
        (v) vconf ;;
        (x) exconf ;;
        (z) zconf ;;
    esac
}

function leader_key() {
    local key
    read -sk 1 key
    case $key in
        (c) leader_config ;;
        (d) datadog ;;
        (g) gup ;;
        (n) nvim_update ;;
        (o) program ;;
        (p) leader_programming ;;
        (r) rag ;;
        (s) leader_ssh;;
        (w) wall ;;
        (z) zellagio ;;
    esac
}

zle -N leader_key

bindkey '^@' leader_key
