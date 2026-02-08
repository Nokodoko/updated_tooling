export PGROOT="$HOME/databases"
export PGPORT=5433

alias pg='postgres'

function p(){
  pg_ctl -D $PGROOT $@
}

