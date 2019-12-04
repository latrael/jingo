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

# telnet
# ssh
# vsftp
# disaleprinters
# disableipspoofing
# disableipforwarding
# syncookie
# disableipv6
# disableguest
# sysCtlsecure
# RootPasswdChange

startFunctions() {
	vsftp
	disableipspoofing
	disableipforwarding
	syncookie
	disableipv6
	disableguest
	disableprinters
	ssh
	telnet
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

disableprinters(){
	systemctl stop cups-browsed
	sleep 5
	systemctl disable cups-browsed
	printf "\n Disabled automic printer installation! \n"
	cont
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

vsftp() {
echo -n "VSFTP [Y/n] "
read option
if [[ $option =~ ^[Yy]$ ]]
then
  sudo apt-get -y install vsftpd
  # Disable anonymous uploads
  sudo sed -i '/^anon_upload_enable/ c\anon_upload_enable no' /etc/vsftpd.conf
  sudo sed -i '/^anonymous_enable/ c\anonymous_enable=NO' /etc/vsftpd.conf
  # FTP user directories use chroot
  sudo sed -i '/^chroot_local_user/ c\chroot_local_user=YES' /etc/vsftpd.conf
  sudo service vsftpd restart
else
  sudo apt-get -y purge vsftpd*
  sudo apt-get autoremove
fi
}

ssh() {
echo -n "SSHD [Y/n] "
read option
if [[ $option =~ ^[Yy}$ ]]
then
  sudo apt-get -y ssh
  printf "\n setting SSH port to 255 \n"
  # sets port to 255
  sudo sed -i '/^Port/ c\Port 255' /etc/ssh/sshd_config
  sudo sed -i '/^PermitRootLogin/ c\PermitRootLogin no' /etc/ssh/sshd_config
  sudo sed -i '/^PermitEmptyPasswords/ c\PermitEmptyPasswords no' /etc/ssh/sshd_config
  sudo sed -i '/^IgnoreRhosts/ c\IgnoreRhosts yes' /etc/ssh/sshd_config
  sudo sed -i '/^HostbasedAuthentication/ c\HostbasedAuthentication no' /etc/ssh/sshd_config
  sudo sed -i '/^X11Forwarding/ c\X11Forwarding no' /etc/ssh/sshd_config
 else
 sudo apt-get -y purge ssh
 sudo apt-get autoremove
fi
}

telnet() {
  sudo apt-get remove telnet
}

apache() {
echo -n "apache [Y/n] "
read option
if [[ $option =~ ^[Yy}$ ]]
then
  sudo apt-get install -y apache2
else
fi
}

RootPasswdChange() {
printf "\n Disabling root's passwd \n \n"
# disables root's passwd
passwd -l root
cont
}




startFunctions
