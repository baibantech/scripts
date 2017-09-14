#!/bin/bash

keep_load() {
  sleep 0
}

toBytes() {
  echo $1 | echo $((`sed 's/.*/\L\0/;s/t/Xg/;s/g/Xm/;s/m/Xk/;s/k/X/;s/b//;s/X/ *1024/g'`))
}

inject_load ()
{
  memsize=$(toBytes $1)
  ./quickfill -m $memsize -f /mem/m${2}.bin
}

remove_load ()
{
  rm -f /mem/m${1}.bin
}
