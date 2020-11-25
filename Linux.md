## A linux checklist of some sort is below:

Topics below needed to be researched:
- Group UID (/etc/groups)
- User ID (/etc/passwd)
- Hosts File (/etc/hosts)
- invalid bash shell(ex. shell installed at /bin/bluray)
- making sure to delete users using ```userdel [username]```
- /etc/shadow file (https://www.cyberciti.biz/faq/understanding-etcshadow-file/)
- ```sudo chown root:admin /bin/su sudo``` | ```chmod 04750 /bin/su``` ( limiting access to "su" program)
- /etc/login.defs ( login?)
- /etc/lightdm/lightdm.conf ( ```allow-guest=false```)
- (https://drive.google.com/drive/u/0/folders/18KnypM_-kYaHFF77eN2t14xIszFuwh0Y)
- CRON TABS!!!!


## PAM Modules, Passwords
Pluggable Authentication Modules(PAM) are used for logon and applications.

### MAKE SURE YOU ARE CAREFUL EDITING THIS FILE, MAKE A LOG OF EVERYTHING THAT YOU HAVE DONE BEFORE IN CASE YOU LOCK YOURSELF OUT. You have been warned.

Make sure you have cracklib installed by running ```sudo apt-get install libpam-cracklib```.

To edit the PAM configuration file, go to the terminal and type ```gedit /etc/pam.d/common‐password```. To enforce a password history, look for the line that has ```pam_unix.so``` and at the end of that line, type ```remember=5```. On that same line, add ```minlen=10``` to configure the minimum length.

To add password requirements, find the line that has ```pam_cracklib.so```(thats why you made sure cracklib was installed), and add the following to the end of that line. 

```ucredit=‐1 lcredit=‐1 dcredit=‐1 ocredit=‐1```

A key for the above is below:

```ucredit```:
- upper case

```lcredit```:
- lower case

```dcredit```:
- number

```ocredit```:
  - symbol

### Secure shared memory
   
Shared memory can be used in an attack against a running service. Modify /etc/fstab to make it more secure. 

Open a Terminal Window and enter the following:
``` shell
sudo gedit /etc/fstab
```

Make sure to add the following line to the end of the document:
```
tmpfs     /run/shm     tmpfs     defaults,noexec,nosuid     0     0
```

## Prevent IP Spoofing(technique #348454573457389457934)

Open a terminal and type the following:

``` shell
sudo gedit /etc/host.conf
```

Edit the document to get the following:

```
order bind,hosts
nospoof on
```

## DenyHosts

DenyHosts is a python program that automatically blocks SSH attacks by adding entries to /etc/hosts.deny. DenyHosts will also inform Linux administrators about offending hosts, attacked users and suspicious logins.

After running ``` apt-get update```, run the following:

``` shell
sudo apt-get install denyhosts
```

After installation edit the configuration file /etc/denyhosts.conf  and change the email, and other settings as required.

To edit the admin email settings open a terminal window and enter:
``` shell
sudo gedit /etc/denyhosts.conf
```

Edit to what you need to edit it to:

```
ADMIN_EMAIL = root@localhost
SMTP_HOST = localhost
SMTP_PORT = 25
#SMTP_USERNAME=foo
#SMTP_PASSWORD=bar
SMTP_FROM = DenyHosts nobody@localhost
#SYSLOG_REPORT=YES 
```
## Fail2Ban
Fail2ban is more advanced than DenyHosts as it extends the log monitoring to other services including SSH, Apache, Courier, FTP, and more.
Fail2ban scans log files and bans IPs that show the malicious signs -- too many password failures, seeking for exploits, etc. Generally Fail2Ban then used to update firewall rules to reject the IP addresses for a specified amount of time, although any arbitrary other action could also be configured.
Out of the box Fail2Ban comes with filters for various services (apache, courier, ftp, ssh, etc).

To install Fail2Ban, make sure that you ran ```sudo apt-get update``` first, then run the following:
``` shell
sudo apt-get install fail2ban
```
After installation edit the configuration file /etc/fail2ban/jail.local  and create the filter rules as required.

To edit the settings open a terminal window and enter:
``` shell
sudo gedit /etc/fail2ban/jail.conf
```

Activate all the services you would like fail2ban to monitor by changing enabled = false to enabled = true

For example if you would like to enable the SSH monitoring and banning jail, find the line below and change enabled from false to true. Thats it.
```
[sshd]

enabled  = true
port     = ssh
filter   = sshd
logpath  = /var/log/auth.log
maxretry = 3
```
For SSH, if you already changed the default port in the sshd.config file, then you need to specify that port where it says ```port   = ```.
When you finish configuring Fail2Ban to your liking, make sure to restart the service:
``` shell
sudo service fail2ban restart
```
You can also check the status with: ```sudo fail2ban-client status```

### securing with Fail2Ban
First make sure that the service has started by running: ```systemctl start fail2ban && systemctl enable fail2ban```.
Go in and edit the config file: ```sudo gedit /etc/fail2ban/jail.local```.

Below is an excerpt from the document, make sure that it matches.

```
# "bantime" is the number of seconds that a host is banned.
bantime  = 900

# A host is banned if it has generated "maxretry" during the last "findtime"
# seconds.
findtime = 600
maxretry = 5
```
## Networking in general
```netstat``` is a very useful command to find out what is running on your network, and see what ports are possibly being used. There are some useful commands below that go in greater detail about netstat.

1. ```netstat -ntpul```
- This is mainly used to see the IP Address and the ports that are being used on the computer. There is almost always a red flag if you see connections that are established if they are other then 127.0.0.1(localhost). This may hint at a backdoor in your system.

## Users
There are certain files that you look through to aid in checking for accounts and groups that do not belong, or may have root access. By typing ```cat /etc/passwd```, you can see all of the users with their encrypted password, as well as their UID. Make sure that there isn't a user with the UID of 0, as that user is root.

## Services
You can use ```bum```(Boot-up Manager) to view services and enable/disable them. You can install BUM by typing in to the terminal ```sudo apt-get install bum```. Once you have BUM installed, you can type ```bum``` to run the program. 

If you do have xinetd installed, you can view the file located at ```/etc/xinetd.d```. To disable a service this way, you can add ```disable = yes``` to the end of whatever service you want to delete.

A list of services to generally disable, **keeping the README in mind** is:
- Telnet
- Anonymous FTP
- remote processes(Rexec.Rlogin,Rsh)
- Rstatd
- Finger
- Talk,Ntalk
- rsh
- rlogin

### Processes
You can check running processes by running ```ps -ef``` in the terminal.
## Auditing
Auditing isn't automatically "downloaded" or "set-up" like it is in Windows, so you have to install ```auditd``` to set it up. To install it, open the trusty terminal up and type ```sudo apt-get install auditd```.

To enable audits, in the terminal, type ```auditd -e 1```. You can view and modify policies by viewing the config file, which is located at ```/etc/auditd/auditd.conf```. 

If you want to set ```auditd``` to check certain files for changes, like the passwd file, then type:

```auditctl -w /etc/passwd -p war -k password-file```.

## Rootkits
Rootkits are somewhat less common, at least in Cyberpatriots, but I might as well show you how to check for it.
Start by installing a rootkit checker, by typing ```sudo apt-get install rkhunter``` into the terminal. Then, once it is installed, to check for rootkits, type ```sudo rkhunter --check --enable apps```. 
## Media Files and Other
Usually in an image there are certain media files, as well as other prohibited files that need to be deleted off of the machine. You can use the "find" command in the terminal to find files based on their extension, who owns the file, and other parameters that you can find out by using ```man find```.

## iptables
You can use iptables, a powerful program, in order to block common network attacks, by setting network settings. Make sure that iptables is installed by running ```sudo apt-get install iptables```. You can type ```man iptables```.

To force SYN packets check, then run: ```iptables -A INPUT -p tcp ! --syn -m state --state NEW -j DROP```.

To drop XMAS packets, then run: ```iptables -A INPUT -p tcp --tcp-flags ALL ALL -j DROP```.

To drop null packets, then run: ```iptables -A INPUT -p tcp --tcp-flags ALL NONE -j DROP```.

Drop incoming packets with fragments: ```iptables -A INPUT -f -j DROP```.

## in depth with SSH
SSH, if enabled on the machine, needs to be secured. First make sure that ssh is installed.

https://help.ubuntu.com/community/SSH/OpenSSH/Configuring : This link gives an in depth tutorial on setting up and decent security policies. 

## FTP
Resources:
https://help.ubuntu.com/community/vsftpd 

### Steps to secure using SSL/TLS
This creates a sub-directory to store the SSL and TLS keys.

```sudo mkdir /etc/ssl/private```

This generates the keys and the certificate in a single file. 

```sudo openssl req -x509 -nodes -keyout /etc/ssl/private/vsftpd.pem -out /etc/ssl/private/vsftpd.pem -days 365 -newkey rsa:2048```

#### the line above will require that you answer a couple of questions

Now, make sure that you have UFW/GUFW enabled and installed for the next step. The command below will allow the connections in the massive range for TCP.
```
sudo ufw allow 990/tcp
sudo ufw allow 40000:50000/tcp
sudo ufw status
```

Open up the VSFTPD configuration file(for me I use gedit)

```sudo gedit /etc/vsftpd/vsftpd.conf```

Locate the option ```ssl_enable```, and set its value to YES, as well as the other settings below.

```
ssl_enable=YES
ssl_tlsv1=YES
ssl_sslv2=NO
ssl_sslv3=NO
```
Next, comment out the lines that follow:

```
#rsa_cert_file=/etc/ssl/private/ssl-cert-snakeoil.pem
#rsa_private_key_file=/etc/ssl/private/ssl-cert-snakeoil.key
```
At the end of the document, add the following lines which defines where the location of the certificate and the key file is located.

```
rsa_cert_file=/etc/ssl/private/vsftpd.pem
rsa_private_key_file=/etc/ssl/private/vsftpd.pem
```
The next step involves restricting access for anonymous users, for obvious reasons. The lines in the config file are listed below.
```
allow_anon_ssl=NO
force_local_data_ssl=YES
force_local_logins_ssl=YES
```

The next couple of settings are little tweaks that improve the overall security. 

```require_ssl_reuse=NO```

```ssl_ciphers=HIGH```

```
pasv_min_port=40000
pasv_max_port=50000
```

```
debug_ssl=YES
```

Finally, reset the service using systemctl.

```systemctl restart vsftpd```

## OPENSSH LOCKDOWN
(source: https://www.digitalocean.com/community/tutorials/how-to-harden-openssh-on-ubuntu-18-04 | there are more complicated things on there)
Here we go! First, open the configuration file.

```sudo gedit /etc/ssh/sshd_config```

Find the line with ```PermitRootLogin``` and set it to the following:

```PermitRootLogin no``` | This prevents someone from logging in directly as root.

Next, we will limit the maximum numer of authentication attemps for a particular login session

```MaxAuthTries 3``` | 3 is considered a standard value for most setups.

Next, we will set a login grace period, which is the amount of time a user has to login and complete authentication(in seconds).

```LoginGraceTime 20``` | This is optional, and you can mess with the value based on your needs.

This next setting depends on the system you've configured. If SSH keys are configured to be used rather then passwords, then use the setting below to disable passowrd authentication, otherwise ignore.

```PasswordAuthentication no```

More related to security with passwords, you can disable the use of empty passwords which is an obvious security risk.

```PermitEmptyPasswords no```

The next settng, X11 forwarding allows for graphical applications over an SSH connection, but its rarely used. If not used on your server, disable it.

```X11 Forwarding no```

OpenSSH allows connecting cilients to pass custom environment variables, but like X11, it's not commonly used, so if that doesn't apply to your server, then it can be disabled.

```PermitUserEnvironment no```

If you won't be using tunneling and forwarding on your server, then you can disable the folllowing misc. options.


```
AllowAgentForwarding no
AllowTcpForwarding no
PermitTunnel no
```

Make sure to enable OpenSSH to use PAM

```UsePAM yes```

Now, you can disable the SSH banner that's enabled by default, which shows information on your system, like the operating system version.

```DebianBanner no``` | this option will likely not be present in the config file, so you will have to add it manually.

Now you can save and exit the config file. Run ```sudo sshd -t``` to validate your syntax, and if there is not output, then there aren't any syntax errors.

Now that you are satisfied with the config file, you can reload the service.

```sudo service sshd reload```

# NEW CHANGES(BEWARE)
## Sudo
Verify that sudo is installed:

```sudo dpkg -s sudo``` | IF NOT INSTALLED : ```sudo apt-get install sudo```

Make sure that sudo can only run other commands from a psuedo-pty

```sudo  grep -Ei '^\s*Defaults\s+([^#]+,\s*)?use_pty(,\s+\S+\s*)*(\s+#.*)?$' /etc/sudoers /etc/sudoers.d/*
Defaults use_pty
```

## Filesystem
Ensure that the filesystem integrity is regularly checked. Run the following commands in order.

```sudo apt-get install aide aide-common```

```sudo systemctl is-enabled aidecheck.service```

```sudo systemctl status aidecheck.service```

```sudo systemctl is-enabled aidecheck.timer```

```sudo systemctl status aidecheck.timer```

## Secure Boot
Check to see that root is the only group/user that has access to the bootloader. Make sure it looks like ```Access: (0400/-r--------) Uid: ( 0/ root) Gid: ( 0/ root)```

```sudo stat /boot/grub/grub.cfg``` | If it shows anything other then above, then run the following commands.

```sudo chown root:root /boot/grub/grub.cfg``` | ```sudo chmod og-rwx /boot/grub/grub.cfg```

## xinetd

Remove xinetd unless otherwise stated by the README

```sudo apt-get purge xinetd```

```sudo apt-get purge openbsd-inetd```

## Services
### Avahi & CUPS & DHCP & LDAP & DNS & FTP & HTTP & Email & Samba & HTTP Proxy & SNMP & rsync & NIS & rsh & talk & telnet
Usually not used unless server is for specifc purpose. Title corresponds to the order of the commands.

```sudo systemctl --now disable avahi-daemon```

```sudo systemctl --now disable cups```

```sudo systemctl --now disable isc-dhcp-server``` | ```sudo systemctl --now disable isc-dhcp-server6```

```sudo systemctl --now disable slapd``` | ```sudo apt-get purge ldap-utils```

```sudo systemctl --now disable bind9```

```sudo systemctl --now disable vsftpd``` | Make sure you get points if you think they are warranted, you might have to uninstall.

```sudo systemctl --now disable apache2``` | Make sure you get points if you think they are warranted, you might have to uninstall.

```sudo systemctl --now disable dovecot``` | Do the following as well: ```sudo ss -lntu | grep -E ':25\s' | grep -E -v '\s(127.0.0.1|::1):25\s'``` --> Nothing should return from this, and if so, run the things below.
```sudo  gedit /etc/postfix/main.cf``` --> ```inet_interfaces = loopback-only``` | ```sudo systemctl restart postfix```

```sudo systemctl --now disable smbd```

```sudo systemctl --now disable squid```

```sudo systemctl --now disable snmpd```

```sudo systemctl --now disable rsync```

```sudo systemctl --now disable nis``` | ```sudo apt-get purge nis```

```sudo apt-get purge rsh-client```

```sudo apt-get remove talk```

```sudo apt-get purge telnet```
