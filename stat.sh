#!/bin/sh

echo "timex        time	date	vm_cnt	used	reclaimed merged	insert	delete	alloc	cpu:	daemon	11	1	13	15	17	19	21	23	3	5	7	9	divide"

while true; 
do 
  sleep 2; 

  vm_cnt=`ps -e | grep qemu- | wc -l`

  used=`free -m| grep 'cache:' | awk '{print $3}'`;
  insert_merge_cnt=`cat /sys/kernel/mm/pone/pone_info | grep "slice merge cnt:" | awk '{sub("\r$", ""); print $4}'`
  delete_merge_cnt=`cat /sys/kernel/mm/pone/pone_info | grep "delete merge page cnt:" | awk '{sub("\r$", ""); print $5}'`
  reclaim_page=`cat /sys/kernel/mm/pone/pone_abstract | grep "page reclaim count" | awk '{sub("\r$", ""); print $4}'`
  alloc_page_cnt=`cat /sys/kernel/mm/pone/pone_info | grep "slice alloc cnt" | awk '{sub("\r$", ""); print $4}'`

  insert_merge_mem=`expr $insert_merge_cnt \* 4 / 1024`
  delete_merge_mem=`expr $delete_merge_cnt \* 4 / 1024`
  merged_mem=`expr $insert_merge_mem - $delete_merge_mem`
  reclaim_mem=`expr $reclaim_page \* 4 / 1024`
  alloc_mem=`expr $alloc_page_cnt \* 4 / 1024`

  cpu_info=`top -bn 1 | grep "sp[td]" | awk {'print $12,$11'} | sort | awk {'print $2'} | sed ':a;N;ba;s/\n/ /g'`
  echo `date +%s`	`date +%Y-%m-%d\ %H:%M:%S`	$vm_cnt	$used	$reclaim_mem	$merged_mem	$insert_merge_mem	$delete_merge_mem	$alloc_mem	$cpu_info
done
