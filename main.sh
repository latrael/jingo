#!/bin/bash

unalias -a #Get rid of aliases
echo "unalias -a" >> ~/.bashrc
echo "unalias -a" >> /root/.bashrc
PWDthi=$(pwd)

if [ "$EUID" -ne 0 ] ;
	then echo "Run as Root"
	exit
fi

# List of all the functions that are going to be run:
#RootPasswdChange

startFunctions() {
	clear

	syncookie
	RootPasswdChange

	printf "\033[1;31mDone!\033[0m\n"
}

cont(){
	printf "\033[1;31mI have finished this task. Continue to next Task? (Y/N)\033[0m\n"
	read contyn
	if [ "$contyn" = "N" ] || [ "$contyn" = "n" ]; then
		printf "\033[1;31mAborted\033[0m\n"
		exit
	fi
	clear
}

syncookie(){
	sysctl -n net.ipv4.tcp_syncookies
	printf "Enabled syncookie protection! \n \n"
	cont
}

RootPasswdChange() {
printf "Changing root's passwd \n \n"
# changes root's password
passwd
cont
}



startFunctions