#!/bin/bash
BIN=$(which VBoxHeadless)
echo -e "[ $(date +%Y-%m-%d_%T) ] -  Starting 'VBoxHeadless -s ubu'" >> /home/tiago/run_on_reboot.txt
#$(which sudo) -u tiago $(which VBoxHeadless) -s "ubu"
$BIN -s "ubu"
