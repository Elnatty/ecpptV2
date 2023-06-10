---
description: done in windows cmd prompt terminal
---

# q - netBOIS and null Session (port 135)

`nmap -sS -p135 $ip` - scan for netbios

`nbtstat -A $ip` - list the table. If we see a result with "<20>" in it, that means theres a file server service available.

`net view $ip`  - view available shares.

`net use \\<share_nework\share_name` - connect to one of the shares found.

### Tools for NetBIOS Auditing

* NetBIOS Auditing Tool (NAT): combines userID and password in order to attempt a connection to the shared resource.

`nat.exe -u <userlist.txt> -p <passlist.txt> $ip` .

* Winpringerprint: a gui tool that when given an ip range or ip address performs several scan in order to find much info as possible about the shared resource.



