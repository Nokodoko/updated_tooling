alias lr='luarocks'
alias lrl='luarocks --list'

function lremove() {
     luarocks remove $1
}

function lp() {
    cl ~/programming/lua_projects/
}

function ladd() {
     luarocks install $1
}

function laddl() {
     luarocks --tree=./ install $1
}

function lshow() {
    luarocks show $1
}

alias lpath="lua -e 'print(package.path)' | tr ';' '\n'"
