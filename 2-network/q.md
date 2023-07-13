---
description: done in windows cmd prompt terminal
---

# q - netBOIS and null Session (port 135)

The main purpose of NetBIOS is to allow apps on different systems to communicate with one another over the LAN. It is used for a multitude of purpose including sharing printers and files, remote procedure callsm exchange messages and much more. As expected these features may reveal additional information such as computer names, usernames, domains, printers, available shares etc.

PC's on a NetBIOS LAN communicate either by establishing a session or by using datagrams, To do this, NetBIOS uses the following TCP and UDP ports:

* **UDP 137 for name services** (DNS record).
* **UDP 138 for datagram services** (allows communication btw computers without the need for a session to be established).
* **TCP 149 for session services** (it allows two names to establish a connection in order to exchange data) using the SMB protocol.

### run in Linux teminal

`nbtscan -v 192.168.0.178` - search a host

`nbtscan -v 192.168.0.0/24` - search a subnet.

### run in Windows CMD-Prompt

`nmap -sS -p135 $ip` - scan for netbios

`nbtstat -A $ip` - list the table. If we see a result with "<20>" in it, that means theres a file server service available. {run in Windows CMD-Prompt}.

`net view $ip`  - view available shares.

`net use \\<share_nework\share_name` - connect to one of the shares found.

### Tools for NetBIOS Auditing

* NetBIOS Auditing Tool (NAT): combines userID and password in order to attempt a connection to the shared resource.

`nat.exe -u <userlist.txt> -p <passlist.txt> $ip` .

* Winpringerprint: a gui tool that when given an ip range or ip address performs several scan in order to find much info as possible about the shared resource.

## For Linux

We use **\[enum4linux]** to enumerate.

`enum4linux -u "vagrant" -p "vagrant" -a -v $ip` - enum all&#x20;

`smbclient \\192.168.0.177\C$` - access a share.

### Smbclient and Mount

mounting file shares

<figure><img src="../.gitbook/assets/image (34).png" alt=""><figcaption><p>1</p></figcaption></figure>

<figure><img src="../.gitbook/assets/image (49).png" alt=""><figcaption><p>2</p></figcaption></figure>

<figure><img src="../.gitbook/assets/image (40).png" alt=""><figcaption><p>3</p></figcaption></figure>

### Null Session

Run these cmds using a Windows cmd prompt.

<figure><img src="../.gitbook/assets/image (47).png" alt=""><figcaption><p>1</p></figcaption></figure>

<figure><img src="../.gitbook/assets/image (45).png" alt=""><figcaption><p>2</p></figcaption></figure>

### Some other tools we can use to gather more shares info are: \[page 432 from the Network Security pdf]

* Winfingerprint (windows tool GUI).
* Winfo - `winfo <TargetIP> -n` - "-n" to establish null session.
* DumpSec (GUI and cmdline tool).
* Enum4linux (linux tool).
* rpcclient (linux) - `rpcclient -N -U "" <targetIP>` where "-N" and '-U ""' is no password and empty username.



