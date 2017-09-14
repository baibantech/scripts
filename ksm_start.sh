#! /bin/sh

sudo date
echo 0 | sudo tee /sys/kernel/mm/ksm/sleep_millisecs
echo 1000000 | sudo tee /sys/kernel/mm/ksm/pages_to_scan
echo 1 | sudo tee /sys/kernel/mm/ksm/run
