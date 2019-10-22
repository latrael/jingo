#!/bin/bash
#MIT Fake License
unalias -a #Get rid of aliases
echo "unalias -a" >> ~/.bashrc
echo "unalias -a" >> /root/.bashrc
PWDthi=$(pwd)
if [ ! -d $PWDthi/referenceFiles ]; then
	echo "Please Cd into this script's directory"
	exit
fi
if [ "$EUID" -ne 0 ] ;
	then echo "Run as Root"
	exit
fi

# List of all the functions that are going to be run:
#RootPasswdChange

startFunctions() {
	clear

	RootPasswdChange
	printf "\033[1;31mDone!\033[0m\n"
}

cont() {
	printf "\033[1;31mI have finished this task. Continue to next Task? (Y/N)\033[0m\n"
	read contyn
	if [ "$contyn" = "N" ] || [ "$contyn" = "n" ]; then
		printf "\033[1;31mAborted\033[0m\n"
		exit
	fi
	clear
}
RootPasswdChange() {
printf "Changing root's passwd"
# disables root's password
passwd

cont
}

startFunctions