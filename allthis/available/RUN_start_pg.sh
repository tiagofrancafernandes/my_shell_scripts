#!/bin/bash
BIN=$(which docker-compose)
sudo $BIN -f /home/tiago/ntfs/projects/ongoing/server/docker-compose.yml up -d pg
