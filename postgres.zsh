alias pg='postgres'

function p(){
  pg_ctl -D $PGROOT $@
}

