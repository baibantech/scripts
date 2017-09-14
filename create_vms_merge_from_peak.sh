#!/bin/sh
VM_PATH=/vm/vdisk/
VM_BASE_IMG=$1
VM_PREFIX=xenial-instance-
VM_MEM_PEAK=204800 # MB

./record.sh

for k in $( seq 2 13)
do
  rm -rf ${VM_PATH}${VM_PREFIX}${k}".qcow2"
  echo start vm${i}...
  qemu-img create -f qcow2 -b ${VM_PATH}${VM_BASE_IMG} ${VM_PATH}${VM_PREFIX}${k}".qcow2"
  sshport=`expr 20000 + $k`
  qemu-system-x86_64 -enable-kvm -m 18432 -device e1000,netdev=net0 -netdev user,id=net0,hostfwd=tcp::${sshport}-:22 -drive file=${VM_PATH}${VM_PREFIX}${k}".qcow2",if=virtio -drive file=${VM_PATH}cloudimg-meta/seed.iso,if=virtio -daemonize -vnc 127.0.0.1:${k}
  
sleep 5

done

