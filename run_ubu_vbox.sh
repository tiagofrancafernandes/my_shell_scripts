#!/bin/bash
BIN=$(which VBoxHeadless)

#echo -e "[ $(date +%Y-%m-%d_%T) ] -  Starting 'VBoxHeadless -s ubu'" >> /home/tiago/run_on_reboot.txt
#$(which sudo) -u tiago $(which VBoxHeadless) -s "ubu"

if [ ! -z $1 ]; then

	if [ $1 == "ubuntu" ]; then
		$BIN -s "ubu"
	elif [ $1 == "debian" ]; then
		$BIN -s "debian10"
	elif [ $1 == "all" ]; then
		$BIN -s "ubu"
		$BIN -s "debian10"
	fi

else
	echo "Carregando maquinas DEFAULT"
	$BIN -s "ubu"
#	$BIN -s "debian10"
fi
