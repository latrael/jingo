# LinuxScripts
Cyberpatriot scripts for Ubuntu/Debian to run through the easier and more redundant steps in the first 30 minutes of Cyberpatriots.

## A checklist of some sort is below:

# Secure shared memory
   
Shared memory can be used in an attack against a running service. Modify /etc/fstab to make it more secure. Open a Terminal Window and enter the following:
``` shell
sudo vi /etc/fstab
```

Make sure to add the following line to the end of the document:
```
tmpfs     /run/shm     tmpfs     defaults,noexec,nosuid     0     0
```
