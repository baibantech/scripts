#!/bin/bash

echo $1 | tee /sys/kernel/mm/pone/pone_daemon_reclaim_period
echo $2 | tee /sys/kernel/mm/pone/pone_daemon_scan_period
