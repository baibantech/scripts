#!/bin/bash

ps aux | grep -ie "load_" | grep -v "grep" | awk '{print "kill -9 " $2}' | sh -x
