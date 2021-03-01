#!/bin/bash
BIN=$(which mount)
DISK=/dev/sda5
$BIN -o remount,rw $DISK
