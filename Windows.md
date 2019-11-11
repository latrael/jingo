## Windows list of things to cover:
### Services
- IIS
- NetMeeting Remote Desktop Sharing VoIP
- Remote Desktop Help Session Manager
- Remote Registry
- Routing and Remote Access
- SimpleFileSharing
- SSD Discovery Service
- Telnet
- FTP
- Universal Plug and Play Device Host
- Windows Messenger Service
 ## Files
 A good way to look for any files that shouldn't exist is to look in ```C:\Windows\System``` or ```C:\Windows\System32```, and look for files that have recent timestamps.
 You can also look in ```C:\Program Files\``` for any suspicious programs, and if you find any programs or files, write down the path of the file and the file name.
 
 A useful "command" to use to help find unauthorized media files is to first:
 - enable hidden files
 - file name extensions
 
 You then want to type in the file explorer: ```file:*(file extension)```.
 If one were to search for all .mp3 files on their system, they would type : ```file:*.mp3``` in the file explorer search bar.
 
### Clearing the host file
 Navigate to ```C:\Windows\System32\drivers\etc\``` and open ```hosts.txt```. The file should look like the following if it is empty:
 ```
 # Copyright (c) 1993-2006 Microsoft Corp.
#
# This is a sample HOSTS file used by Microsoft TCP/IP for Windows.
#
# This file contains the mappings of IP addresses to host names. Each
# entry should be kept on an individual line. The IP address should
# be placed in the first column followed by the corresponding host name.
# The IP address and the host name should be separated by at least one
# space.
#
# Additionally, comments (such as these) may be inserted on individual
# lines or following the machine name denoted by a '#' symbol.
#
# For example:
#
#      102.54.94.97     rhino.acme.com          # source server
#       38.25.63.10     x.acme.com              # x client host
# localhost name resolution is handle within DNS itself.
#       127.0.0.1       localhost
#       ::1             localhost 
 ```
 
 ### Checking for executables
 You can use netstat to look for executables that are listening on ports, and also possibly connected. To check for executables, run ```netstat -anb```.
## Processes
A useful website to use whether processes are legitimate or not is named [processlibrary.com](https://processlibrary.com)

## Windows Features

Make sure that you check the Readme first before tampering with any of the Windows Features. The main things to look for in the Windows Featues are:
- **Internet Explorer**(sadly)
- IIS(make sure Readme doesn't need FTP or Apache)
- SMB/CIFS File Sharing Support
- Telnet Client

Once again, make sure to check the Readme so you do not lose points.

