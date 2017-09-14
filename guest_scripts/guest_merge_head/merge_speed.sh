#!/bin/bash

source $2       #include load.sh

loadcnt=5000000

while :;
do
  inject_load 20M $loadcnt
  if [ $? != 0 ];then
     echo "peak mem ..."
     break
  fi
  loadcnt=$[ loadcnt + 1 ]
  sleep .2
done

