#!/bin/bash
# Made by Quimea
# Check out my github for more


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
# syncookie
# disableipv6
# disableguest
# RootPasswdChange

startFunctions() {
	clear

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

# cronroot(){
#	printf "\n Only allowing cron with root access \n"
#	
	#--------- Allow Only Root Cron ----------------
	#reset crontab
#	crontab -r
#	cd /etc/
#	/bin/rm -f cron.deny at.deny
#	echo root >cron.allow
#	echo root >at.allow
#	/bin/chown root:root cron.allow at.allow
#	/bin/chmod 644 cron.allow at.allow
#	cont
#}


startFunctions
