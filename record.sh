#!/bin/sh

TIME=`date +%Y%m%d-%H%M`
LOG_PATH=/vm/record.log
SUM_LOG=${LOG_PATH}/sum-${TIME}.log
MEM_LOG=${LOG_PATH}/mem-${TIME}.log
CPU_LOG=${LOG_PATH}/cpu-${TIME}.log

./killbyname.sh nmon
./killbyname.sh stat.sh
#./killbyname.sh cpu_stat

nmon -s2 -c43200 -f -m /vm/record.log
./stat.sh > $SUM_LOG &
#./cpu_stat.sh > $CPU_LOG &
