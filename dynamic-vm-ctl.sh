#!/bin/bash
sudo date
echo $1 | sudo tee /sys/kernel/mm/pone/pone_daemon_run

