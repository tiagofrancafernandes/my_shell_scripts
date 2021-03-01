#!/bin/bash
BIN=$(which omnidb-server)
pkill omnidb-server
#$BIN --host=0.0.0.0 --port=22123
$BIN -c /etc/omnidb.conf
