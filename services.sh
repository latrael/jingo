#!/bin/bash

if [ "$EUID" -ne 0 ] ;
	then echo "Run as Root"
	exit
fi

startFunctions() {
	avahi
	cups
	dhcp
	dhcpv6
	ldap
	dns
	ftp_d
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
		dhcpv6
	fi
	sudo systemctl --now disable isc-dhcp-server
	printf "\n Successful! \n"
	cont
}

dhcpv6() {
	printf "\n Disable dhcp v6? \n"
	read disable
	if [ "$disable" = "N" ] || [ "$disable" = "n" ]; then
		printf "\n aborted \n"
		ldap
	fi
	sudo systemctl --now disable isc-dhcp-server6
	printf "\n Successful! \n"
	cont
}

ldap() {
	printf "\n Disable ldap? \n"
	read disable
	if [ "$disable" = "N" ] || [ "$disable" = "n" ]; then
		printf "\n aborted \n"
		dns
	fi
	sudo systemctl --now disable slapd
	sudo apt-get purge ldap-utils
	printf "\n Sucessful! \n"
	cont
}

dns() {
	printf "\n Disable dns? \n"
	read disable
	if [ "$disable" = "N" ] || [ "$disable" = "n" ]; then
		printf "\n aborted \n"
		ftp_d
	fi
	sudo systemctl --now disable bind9
	printf "\n Disabled!! \n"
	cont
}

ftp_d() {
	printf "\n disable ftp? \n"
	read disable
	if [ "$disable" = "N" ] || [ "$disable" = "n" ]; then
		printf "\n aborted \n"
		http
	fi
	sudo systemctl --now disable vsftpd
	sudo apt-get purge vsftpd
	sudo apt-get purge ftp
	printf "\n Disabled!! \n"
	cont
}

http() {
	printf "\n Disable http? \n"
	read disable
	if [ "$disable" = "N" ] || [ "$disable" = "n" ]; then
		printf "\n aborted \n"
		email
	fi
	sudo systemctl --now disable apache2
	sudo apt-get purge apache2
	printf "\n Successful! \n"
	cont
}

email() {
	printf "\n Disable email? \n"
	read disable
	if [ "$disable" = "N" ] || [ "$disable" = "n" ]; then
		printf "\n aborted \n"
		samba
	fi
	sudo systemctl --now disable dovecot
	printf "\n make sure to follow the rest on the repo! \n"
	printf "\n Successful! \n"
	cont
}

samba() {
	printf "\n Disable samba(file sharing) \n"
	read disable
	if [ "$disable" = "N" ] || [ "$disable" = "n" ]; then
		printf "\n aborted \n"
		httpProxy
	fi
	sudo systemctl --now disable smbd
	printf "\n Successful! \n"
	cont
}

httpProxy() {
	printf "\n disable http proxy? \n"
	read disable
	if [ "$disable" = "N" ] || [ "$disable" = "n" ]; then
		printf "\n aborted \n"
		snmp
	fi
	sudo systemctl --now disable squid
	printf "\n Successful! \n"
	cont
}

snmp() {
	printf "\n disable snmp trap? \n"
	read disable
	if [ "$disable" = "N" ] || [ "$disable" = "n" ]; then
		printf "\n aborted \n"
		rsync
	fi
	sudo systemctl --now disable snmpd
	printf "\n Successful! \n"
	cont
}

rsync() {
	printf "\n disable rsync? \n"
	read disable
	if [ "$disable" = "N" ] || [ "$disable" = "n" ]; then
		printf "\n aborted \n"
		nis
	fi
	sudo systemctl --now disable rsync
	printf "\n successful \n"
	cont
}

nis() {
	printf "\n disable nis? \n"
	read disable
	if [ "$disable" = "N" ] || [ "$disable" = "n" ]; then
		printf "\n aborted \n"
		rsh
	fi
	sudo systemctl --now disable nis
	sudo apt-get purge nis
	printf "\n successful \n"
	cont
}

rsh() {
	printf "\n disable rsh? \n"
	read disable
	if [ "$disable" = "N" ] || [ "$disable" = "n" ]; then
		printf "\n aborted \n"
		talk
	fi
	sudo apt-get purge rsh-client
	printf "\n successful \n"
	cont
}

talk() {
	printf "\n disable talk? \n"
	read disable
	if [ "$disable" = "N" ] || [ "$disable" = "n" ]; then
		printf "\n aborted \n"
		telnet
	fi
	sudo apt-get remove talk
	printf "\n successful \n"
	cont
}

telnet() {
	printf "\n disable telnet? \n"
	read disable
	if [ "$disable" = "N" ] || [ "$disable" = "n" ]; then
		printf "\n aborted \n"
		printf "\n Done! \n"
		exit
	fi
	sudo apt-get purge telnet
	printf "\n successful \n"
}

startFunctions