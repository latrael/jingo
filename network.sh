#!/bin/bash

if [ "$EUID" -ne 0 ] ;
	then echo "Run as Root"
	exit
fi

startFunctions() {
	one
	two
	three
	four
	five
	six

	printf "\n done! \n"
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

one() {
	printf "\n Ready? \n"
	read disable
	if [ "$disable" = "N" ] || [ "$disable" = "n" ]; then
		printf "\n aborted \n"
		printf "\n Done! \n"
		exit
	fi
	sudo sysctl -w net.ipv4.conf.all.send_redirects=0
	sudo sysctl -w net.ipv4.conf.default.send_redirects=0
	sysctl -w net.ipv4.route.flush=1
	printf "\n done \n"
	cont
}

two() {
	printf "\n Ready? \n"
	read disable
	if [ "$disable" = "N" ] || [ "$disable" = "n" ]; then
		printf "\n aborted \n"
		printf "\n Done! \n"
		exit
	fi
	sudo grep -Els "^\s*net\.ipv4\.ip_forward\s*=\s*1" /etc/sysctl.conf /etc/sysctl.d/*.conf /usr/lib/sysctl.d/*.conf /run/sysctl.d/*.conf | while read filename; do sed -ri "s/^\s*(net\.ipv4\.ip_forward\s*)(=)(\s*\S+\b).*$/# *REMOVED* \1/" $filename; done; sysctl -w net.ipv4.ip_forward=0; sysctl -w net.ipv4.route.flush=1
	sudo grep -Els "^\s*net\.ipv6\.conf\.all\.forwarding\s*=\s*1" /etc/sysctl.conf /etc/sysctl.d/*.conf /usr/lib/sysctl.d/*.conf /run/sysctl.d/*.conf | while read filename; do sed -ri "s/^\s*(net\.ipv6\.conf\.all\.forwarding\s*)(=)(\s*\S+\b).*$/# *REMOVED* \1/" $filename; done; sysctl -w net.ipv6.conf.all.forwarding=0; sysctl -w net.ipv6.route.flush=1
	printf "\n done \n"
	cont
}

three() {
	printf "\n Ready? \n"
	read disable
	if [ "$disable" = "N" ] || [ "$disable" = "n" ]; then
		printf "\n aborted \n"
		printf "\n Done! \n"
		exit
	fi
	sudo sysctl -w net.ipv4.conf.all.accept_source_route=0
	sudo sysctl -w net.ipv4.conf.default.accept_source_route=0
	sudo sysctl -w net.ipv6.conf.all.accept_source_route=0
	sudo sysctl -w net.ipv6.conf.default.accept_source_route=0
	sudo sysctl -w net.ipv4.route.flush=1
	sudo sysctl -w net.ipv6.route.flush=1
	printf "\n done \n"
	cont
}

four() {
	printf "\n Ready? \n"
	read disable
	if [ "$disable" = "N" ] || [ "$disable" = "n" ]; then
		printf "\n aborted \n"
		printf "\n Done! \n"
		exit
	fi
	sudo sysctl -w net.ipv4.conf.all.accept_redirects=0
	sudo sysctl -w net.ipv4.conf.default.accept_redirects=0
	sudo sysctl -w net.ipv6.conf.all.accept_redirects=0
	sudo sysctl -w net.ipv6.conf.default.accept_redirects=0
	sudo sysctl -w net.ipv4.route.flush=1
	sudo sysctl -w net.ipv6.route.flush=1
	printf "\n done \n"
	cont
}

five() {
	printf "\n Ready? \n"
	read disable
	if [ "$disable" = "N" ] || [ "$disable" = "n" ]; then
		printf "\n aborted \n"
		printf "\n Done! \n"
		exit
	fi
	sudo sysctl -w net.ipv4.conf.all.secure_redirects=0
	sudo sysctl -w net.ipv4.conf.default.secure_redirects=0
	sudo sysctl -w net.ipv4.route.flush=1
	printf "\n done \n"
	cont
}

six() {
	printf "\n Ready? \n"
	read disable
	if [ "$disable" = "N" ] || [ "$disable" = "n" ]; then
		printf "\n aborted \n"
		printf "\n Done! \n"
		exit
	fi
	sudo sysctl -w net.ipv4.conf.all.log_martians=1
	sudo sysctl -w net.ipv4.conf.default.log_martians=1
	sudo sysctl -w net.ipv4.route.flush=1
	printf "\n done \n"
}

startFunctions