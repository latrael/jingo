# LinuxScripts
Cyberpatriot scripts for Ubuntu/Debian to run through the easier and more redundant steps in the first 30 minutes of Cyberpatriots.

## A checklist of some sort is below:

### Secure shared memory
   
Shared memory can be used in an attack against a running service. Modify /etc/fstab to make it more secure. 

Open a Terminal Window and enter the following:
``` shell
sudo vi /etc/fstab
```

Make sure to add the following line to the end of the document:
```
tmpfs     /run/shm     tmpfs     defaults,noexec,nosuid     0     0
```

## Prevent IP Spoofing(technique #348454573457389457934)

Open a terminal and type the following:

``` shell
sudo vi /etc/host.conf
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
sudo vi /etc/denyhosts.conf
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
```
