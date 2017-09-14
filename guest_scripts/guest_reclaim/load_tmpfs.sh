#!/bin/bash
inject_load ()
{
  head -c $1 /dev/urandom > /mem/m${2}.bin
}

remove_load ()
{
  rm -f /mem/m${1}.bin
}
