---
description: Stealth scan using an IDLE scan.
---

# i - Idle Scan (hping and nmap)

An IDLE Scan a technique used to perform a port scan without sending pakets to the target host containing the attacker Ip address. This method is very stealthy as the victim will never know the real attacker ip. All it requires is a third-party host called **"Zombie"** which the attacker will use to bounce the scan.

### How IDLE scan is performed

* The attacker sends some packets to probe the "ID" of a candidate Zombie machine, these machines are called Zombies because of their inactivity on the network. If during the probe the machine increments its ID by 1, we can consider the machine a good Zombie candidate.
* Secondly we send a SYN packet to the target machine by spoofing the Zombie ip address, this means that the target will see the packet coming from the Zombie host instead of the attacker. At this point the target will reply to the request by sending a packet response to the Zombie machine, this will be a SYN ACK if the port is "open" or RST if its "closed". While sending these packets, we monitor the ID of the Zombie machine, if it increments by 1, then the port of the victim host is "closed", but if it increments by 2 , then the ports on the target are "open". This happens because we (attacker) send a SYN packet spoofing the Zombie ip address, the victim replies the Zombie machine with a SYN ACK, then the Zombie will reply with a RST and its ID increments.

## Demonstration

1. Finding a good Zombie target host.

`sudo hping3 -S -r 192.168.0.141 -p 135` - select any host as Zombie, then execute the cmd. We see the ID increment value, if it increments by "+1" that means its a good Zombie candidate which isn't communicatiing with any other machine in the network execpt us.

2. Spoof the Zombie IP, and send SYN packets to the victim. If the target/victim is open there will be a communication btw the Zombie and the victim machine. To execute the SYN scan with the Zombie ip address:

`sudo hping3 -a $<zombie_ip> -S $<victim_ip> -p 23` - if we see the ID increment by "+2" that means the port 23 is open on the victim, but if it remains at "+1" means the port is closed.



## Idle Scan using \[nmap]

[https://nmap.org/book/idlescan.html](https://nmap.org/book/idlescan.html)

### How to check if a host is a good Zombie host

1. if the "ID" increments by "+1"
2. Detects the ip ID sequence status

### Demonstration

1. **using an nmap script to check if a host is a good Zombie candidate.**

`nmap --script ipidseq $ip -p 135` - if the scan returns "Incremental" that means the host is a good Zombie candidate. Like the result in the image below is "All zeros" meaning bad candidate ):

<figure><img src="../.gitbook/assets/image (26).png" alt=""><figcaption></figcaption></figure>

2. **using the OS fingerprint scan.**

Also we have no luck finding a suitable host ):

<figure><img src="../.gitbook/assets/image (27).png" alt=""><figcaption></figcaption></figure>

### Performing IDLE scan using \[nmap]

`sudo nmap -sI $<zombie_ip>:80 $<victim_ip> -p 23 -Pn --packet-trace` - the "--packet-trace" arg ensures nmap prints every packets received and sent by nmap and to help us understand wwhats happening. Equivaent hping cmd is:

`sudo hping3 -S -r $<zombie_ip> -p 80`&#x20;

`sudo nmap -S $<zombie> $<victim_ip> -p 23 -Pn -e eth0  --disable-arp-ping` - mannual check to verify if ports are open or not.
