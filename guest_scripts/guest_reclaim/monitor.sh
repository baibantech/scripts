#!/bin/bash

source $2       #include load.sh

loadcnt=0

rm -rf /mem/*

while :;
do
  used=`free -m | grep 'Mem:' | awk '{print $3}'`
  shared=`free -m | grep 'Mem:' | awk '{print $5}'`
  used_with_shared=`expr $used + $shared`
  echo "used $used_with_shared"
#  peakmem=`expr $(toBytes $1) / 1048576`

#  if [ $used_with_shared -gt $peakmem ];then
#    echo "peak mem ..."
#    break
#  fi
  inject_load 20M $loadcnt
  if [ $? != 0 ];then
     echo "peak mem ..."
     break
  fi
  loadcnt=$[ loadcnt + 1 ]
  sleep .6
done

keep_load	

while [ $loadcnt -ge 0 ];
do
  echo "rm m${loadcnt}.bin"
  remove_load $loadcnt
  loadcnt=$[ loadcnt - 1 ]
  sleep .6
done

#  available=`free -m | grep 'Mem:' | awk '{print $7}'`
#  if [ $available -lt 50 ];then

