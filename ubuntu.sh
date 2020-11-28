#!/bin/bash

if [ "$EUID" -ne 0 ] ;
	then echo "Run as Root"
	exit
fi

startFunctions() {
	avahi
	cups
	dhcp
	ldap
	dns
	ftp
	http
	email
	samba
	httpProxy
	snmp
	rsync
	nis
	rsh
	talk
	telnet
	
	printf "\n Done! \n"
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

avahi() {
	printf "\n Disable avahi? \n"
	read disable
	if [ "$disable" = "N" ] || [ "$disable" = "n" ]; then
		printf "\n aborted \n"
		cups
	fi
	sudo systemctl --now disable avahi-daemon
	printf "\n Successful! \n"
	cont
}

cups() {
	printf "\n Disable cups? \n"
	read disable
	if [ "$disable" = "N" ] || [ "$disable" = "n" ]; then
		printf "\n aborted \n"
		dhcp
	fi
	sudo systemctl --now disable cups
	printf "\n Successful! \n"
	cont
}

dhcp() {
	printf "\n Disable dhcp? \n"
	read disable
	if [ "$disable" = "N" ] || [ "$disable" = "n" ]; then
		printf "\n aborted \n"
		exit
	fi
	sudo systemctl --now disable isc-dhcp-server
	printf "\n Successful! \n"
	wait 5
	printf "\n Disable dhcp v6? \n"
	read disable
	if [ "$disable" = "N" ] || [ "$disable" = "n" ]; then
		printf "\n aborted \n"
		exit
	fi
	sudo systemctl --now disable isc-dhcp-server6
	printf "\n Successful! \n"
}

startFunctions