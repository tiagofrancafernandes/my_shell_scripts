#! /usr/bin/expect -f

##################################################
# TODO:
# -PEM File by paramns (optional)
##################################################


##################################################
# CURRENT CREDITS
##################################################
# Copyright (C) 2019 Tiago França.
#
# Author:     Tiago França <contato@tiagofranca.com>
##################################################


##################################################
# ORIGINAL CREDITS
##################################################
# Copyright (C) 2011 ~ 2016 Deepin, Inc.
#
# Author:     Wang Yong <wangyong@deepin.com>
##################################################

## All possible interactive messages:
# Are you sure you want to continue connecting (yes/no)?
# password:
# Enter passphrase for key

## Main
# Delete self for secret, will not affect the following code
#file delete $argv0

# Setup variables
# Set timeout -1 to avoid remote server dis-connect.

set SHOW_PASSWORD_CASE_REFUSED {yes}
set IP_ARG_TO_CONNECT [lindex $argv 0]
set USER_ARG [lindex $argv 1]
set PASS_ARG [lindex $argv 2]
set PORT_ARG [lindex $argv 3]
set VERIFIED 0
set HELP "\nTo use:\n\t\[help\]\t\t\t\t\t\tShow this content\n\t\[server *\] \[user *\] \[pass *\] \[port\]\t\tData connection. With \* is required\n"

if {$IP_ARG_TO_CONNECT=="help"} {
    puts "$HELP"
    exit
}

if {$IP_ARG_TO_CONNECT!=""} {
    set SERVER_TO_CONNECT $IP_ARG_TO_CONNECT
    incr VERIFIED
} else {
	puts "\Please, enter the SERVER"
}

if {$USER_ARG!=""} {
    set USER $USER_ARG
    incr VERIFIED
} else {
	puts "\Please, enter the USER"
}

if {$PASS_ARG!=""} {
    set PASS $PASS_ARG
    incr VERIFIED
} else {
	puts "\Please, enter the PASS"
}


if {$PORT_ARG!=""} {
    set PORT $PORT_ARG
    incr VERIFIED
} else {
	set PORT 22
    incr VERIFIED
}

if {$VERIFIED < 4} {
    puts "$HELP"
    puts "\VERIFIED $VERIFIED inputs"
	exit
} 


puts "\n\n\tConnecting to $SERVER_TO_CONNECT\n\n\n"

set timeout -1
set user $USER
set server $SERVER_TO_CONNECT
set password $PASS
set private_key {}
set port $PORT
set authentication {no}
set ssh_cmd {/usr/lib/deepin-terminal/zssh -X -o ServerAliveInterval=60}
set ssh_opt {$user@$server -p $port -o PubkeyAuthentication=$authentication}
set remote_command {echo Bem-vindo ao Terminal, por favor, certifique-se de que os comandos rz e sz foram instalados no servidor antes de usar o botão direito do mouse para enviar e baixar arquivos. &&}

if {$SHOW_PASSWORD_CASE_REFUSED=="yes"} {
    set case_refused "\nFail to connect\nSERVER:$server USER:$user PORT:$port PASS:$password\n"
} else {
	set case_refused "\nFail to connect\nSERVER:$server USER:$user PORT:$port\n"
}

# This code is use for synchronous pty's size to avoid terminal not update if login in remote server.
trap {
    stty rows [stty rows] columns [stty columns] < $spawn_out(slave,name)
} WINCH

# Spawn and expect
eval spawn $ssh_cmd $ssh_opt $private_key -t $remote_command exec \\\$SHELL -l
if {[string length $password]} {
    expect {
        timeout {send_user "ssh connection time out, please operate manually\n"}
        -nocase "(yes/no)\\?" {send "yes\r"; exp_continue}
        -nocase "*refused*" {puts $case_refused}
        -nocase -re "password:|enter passphrase for key" {
            send "$password\r"
		}
	}
	
}
interact

