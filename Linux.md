## A linux checklist of some sort is below:

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
## Networking in general
```netstat``` is a very useful command to find out what is running on your network, and see what ports are possibly being used. There are some useful commands below that go in greater detail about netstat.

1. ```netstat -ntpul```
- This is mainly used to see the IP Address and the ports that are being used on the computer. There is almost always a red flag if you see connections that are established if they are other then 127.0.0.1(localhost). This may hint at a backdoor in your system.

## Users
There are certain files that you look through to aid in checking for accounts and groups that do not belong, or may have root access. By typing ```cat /etc/passwd``` to check 
