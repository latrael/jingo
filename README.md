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

## Fail2Ban and DenyHosts

DenyHosts is a python program that automatically blocks SSH attacks by adding entries to /etc/hosts.deny. DenyHosts will also inform Linux administrators about offending hosts, attacked users and suspicious logins.

After running ``` apt-get update```, run the following:

``` shell
sudo apt-get install denyhosts
```
