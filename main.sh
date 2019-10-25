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

# disableipspoofing
# disableipforwarding
# syncookie
# disableipv6
# disableguest
# sysCtlsecure
# RootPasswdChange

startFunctions() {
	clear

	disableipspoofing
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

disableipspoofing(){
	printf "\n Disabling IP Spoofing!"
	echo "nospoof on" >> /etc/host.conf
	printf "Successful!"
	cont
}

disableipforwarding(){
	printf "\n Diabling IP Forwarding \n"
	echo 0 > /proc/sys/net/ipv4/ip_forward
	printf "\n Successful!"
	cont
}

syncookie(){
	printf "\n \n Press Y to edit syncookie \n \n"
	cont
	gedit /etc/sysctl.d/10-network-security.conf
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

sysCtlsecure(){
	printf "\n Making SysCtl secure \n"
		#--------- Secure /etc/sysctl.conf ----------------
		sysctl -w net.ipv4.tcp_syncookies=1
		sysctl -w net.ipv4.ip_forward=0
		sysctl -w net.ipv4.conf.all.send_redirects=0
		sysctl -w net.ipv4.conf.default.send_redirects=0
		sysctl -w net.ipv4.conf.all.accept_redirects=0
		sysctl -w net.ipv4.conf.default.accept_redirects=0
		sysctl -w net.ipv4.conf.all.secure_redirects=0
		sysctl -w net.ipv4.conf.default.secure_redirects=0
		sysctl -p
		printf "Successful!"
		cont
	}
}

RootPasswdChange() {
printf "\n Changing root's passwd \n \n"
# disables root's passwd
passwd -l root
cont
}




startFunctions
