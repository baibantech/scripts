#!/bin/bash

ps aux | grep -ie "$1" | grep -v "grep" | awk '{print "kill -9 " $2}' | sh -x
