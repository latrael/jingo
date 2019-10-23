#!/bin/bash

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
# disableipforwarding
# syncookie
# disableipv6
# disableguest
# RootPasswdChange

startFunctions() {
	clear

	disableipforwarding
	syncookie
	disableipv6
	disableguest
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

disableipforwarding(){
	printf "\n Diabling IP Forwarding \n"
	echo 0 > /proc/sys/net/ipv4/ip_forward
	printf "\n Successful!"
	cont
}

syncookie(){
	sysctl -n net.ipv4.tcp_syncookies
	printf "\n \n Enabled syncookie protection! \n \n"
	cont
}

disableipv6(){
	sudo echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
	printf "\n Successfully disabled ipv6! \n"
	cont

}

disableguest(){
	printf "\n Disabling Guest Account! \n"
	cat $PWDthi/referenceFiles/lightdm.conf > /etc/lightdm/lightdm.conf
	cont
}

RootPasswdChange() {
printf "Changing root's passwd \n \n"
# changes root's password
passwd
cont
}




startFunctions