#!/bin/sh

while true; 
do 
  sleep 2; 
  used=`free -m| grep 'cache:' | awk '{print $3}'`;
  merged_cnt=`cat /sys/kernel/mm/ksm/pages_sharing`
  
  merged_mem=`expr $merged_cnt \* 4 / 1024`
  echo `date +%s`	`date +%Y-%m-%d\ %H:%M:%S`	$used	$merged_mem
done
