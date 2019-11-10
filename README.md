# Cyberpatriots from Team Beta, Rangeview High School

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
 ## Suspicious Files
 A good way to look for any files that shouldn't exist is to look in ```C:\Windows\System``` or ```C:\Windows\System32```, and look for files that have recent timestamps.
 You can also look in ```C:\Program Files\``` for any suspicious programs, and if you find any programs or files, write down the path of the file and the file name.
 
 A useful "command" to use to help find unauthorized media files is to first:
 - enable hidden files
 - file name extensions
 
 You then want to type in the file explorer: ```file:*(file extension)```.
 If one were to search for all .mp3 files on their system, they would type : ```file:*.mp3``` in the file explorer search bar.
 
## Processes
A useful website to use whether processes are legitimate or not is named [processlibrary.com](https://processlibrary.com)
