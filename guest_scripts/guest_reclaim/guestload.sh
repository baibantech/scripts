#!/bin/bash

function random_gen()
{
    min=$1;
    max=$2-$1;
    num=$(date +%s+%N);
    ((retnum=num%(max-min)+min))
    echo $retnum;
}

if [ $# != 5 ]; then
  echo " "
  echo "Usage: $0 -r|--run XX -i|--idle YY -m|--memory ZZ workload"
  echo "    -r, --run: run duration in XX seconds"
  echo "    -i, --idle: idle duration in YY seconds"
#  echo "    -m, --memory: peak memory in ZZ[K,M,G]"
  echo "    load: workload: for system."
  exit 1
fi
  
while [[ $# -gt 0 ]] 
do
  case "$1" in
    -r|--run)
      runtime=$2
      shift 2
      ;;
    -i|--idle) 
      idletime=$2
      shift 2
      ;;
#    -m|--memory) 
#      peakmem=$2
#      shift 2
#      ;;
    *) 
      load=$1
      echo "load $1"
      shift
      ;;
    --) 
      shift
      break 
      ;;
  esac
done

total=`free -m | grep 'Mem:' | awk '{print $2}'`
peakmem=`expr $total - 70`"M"
echo "peak mem $peakmem"

while true
do
  beforeloadstart=$(random_gen 0 $idletime)
  sleep $beforeloadstart
  echo "beforeloadstart sleep $beforeloadstart"
  ./monitor.sh $peakmem $load &
  ((afterloadstart=$idletime+$runtime-$beforeloadstart))
  echo "afterloadstart sleep $afterloadstart"
  sleep $afterloadstart
done






