#!/bin/bash
umount /mem
mount -t tmpfs -o size=16G tmpfs /mem

./monitor.sh 0 load_quickfillsample_256.sh
