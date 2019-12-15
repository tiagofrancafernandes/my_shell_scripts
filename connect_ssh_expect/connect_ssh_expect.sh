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

set IP_ARG_TO_CONNECT [lindex $argv 0]
set USER_ARG [lindex $argv 1]
set PASS_ARG [lindex $argv 2]
set PORT_ARG [lindex $argv 3]
set SHOW_PASS_ARG [lindex $argv 4]
set VERIFIED 0
set HELP "\n\t________________________\nTo use:\n\t\[help\]\n\t\[server *\] \[user *\] \[pass *\] \[port\] \[show_pass\]\n\tWith \* is required.\n\t________________________\n\t\[help\] ------------ Show this content.\n\t\[show_pass\] ------------ Show password in details if param is \"show\"\n\t\[port\] ------------ Port. Default port is 22.\n\n\t\!\!\! In case has special chars you need scape using \\"

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

if {$PORT_ARG=="show"} {
    set PORT_ARG 22
    set SHOW_PASS_ARG {show}
}

if {$PORT_ARG!=""} {
    set PORT $PORT_ARG
    incr VERIFIED
} else {
	set PORT 22
    incr VERIFIED
}

if {$SHOW_PASS_ARG=="show"} {
    set SHOW_PASSWORD_IN_DETAILS {yes}
    incr VERIFIED
} else {
	set SHOW_PASSWORD_IN_DETAILS {no}
    incr VERIFIED
}

if {$VERIFIED < 4} {
    puts "$HELP"
    puts "\n\tVERIFIED $VERIFIED inputs"
	exit
} 


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

if {$SHOW_PASSWORD_IN_DETAILS=="yes"} {
    set connecton_details "SERVER:$server USER:$user PASS:$password PORT:$port\n"
} else {
	set connecton_details "SERVER:$server USER:$user PORT:$port\n"
}


puts "\n\n\tConnecton details: $connecton_details\n\n\n"

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
        -nocase "*refused*" {puts "\nFail to connect\n$connecton_details"}
        -nocase -re "password:|enter passphrase for key" {
            send "$password\r"
		}
	}
	
}
interact

