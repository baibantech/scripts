#!/bin/bash

source $2       #include load.sh

loadcnt=0

rm -rf /mem/*

while :;
do
  used=`free -m | grep 'Mem:' | awk '{print $3}'`
  shared=`free -m | grep 'Mem:' | awk '{print $5}'`
  used_with_shared=`expr $used + $shared`
#  echo "used $used_with_shared"

  inject_load 20M $loadcnt
  if [ $? != 0 ];then
     echo "peak mem ..."
     break
  fi
  loadcnt=$[ loadcnt + 1 ]
#  sleep .6
done

