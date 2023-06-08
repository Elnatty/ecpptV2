# g - Host Discovery with fping, hping, nmap

### \[fping]

`fping $ip -A` - sends icmp requests and display alive hosts in network.

`fping -A 192.168.0.114 -r 0` - set number of retries to 0.

`fping -A 192.168.0.114 -e` - time it takes to reach the host.

`fping -q -a -g 192.168.0.1/24 -r 0 -e` - standard host discovery cmd.

### \[hping]

`sudo hping3 -1 192.168.0.112 -c 1` - "-1"=icmp pings,  "-c"=counts.

`sudo hping3 --icmp-ts 192.168.0.112 -c 2 -V` - timestamp with icmp.

`sudo hping3 -2 192.168.0.112 -c 2` - udp ping.

`sudo hping3 -S 192.168.0.112 -c 2 -p 80` - TCP SYN scan on port 80.

`sudo hping3 -F 192.168.0.112 -c 2 -p 80` -  TCP FIN scan.

`sudo hping3 -U 192.168.0.112 -c 2 -p 80` - URGENT scan.

`sudo hping3 -X 192.168.0.112 -c 2 -p 80` - XMAS scan (FIN, URG, and PSH flags set to 1).

`sudo hping3 -F -P -U 192.168.0.112 -c 2 -p 80` - mannual XMAS scan.

`sudo hping3 -Y 192.168.0.112 -c 2 -p 80` -  YMAS scan (SYN, FIN, URG, and PSH flags are set to 1).

`udo hping3 -1 192.168.0.x --rand-dest -I eth0` - sending/scanning entire subnet with icmp messages.

### \[nmap]

`man nmap| grep -e "-sn"` - help for any argument in kali.

`sudo nmap 192.168.0.112 -sn` - DNS.

`sudo nmap 192.168.0.112 -sn --disable-arp-ping` - send ICMP echo requests to check if a client is UP or OFF.

`sudo nmap 192.168.0.112 -sn --disable-arp-ping -PS 53` - send TCP SYN packets to the target IP.

`sudo nmap 192.168.0.112 -sn --disable-arp-ping -PA` - send TCP ACK packets to the target IP

`sudo nmap 192.168.0.112 -sn --disable-arp-ping -PU` - send UDP packet to victim.

`sudo nmap 192.168.0.112 -sn --disable-arp-ping -PY` - TCP SCTP packets for the ping sweep. SCTP (Stream Control Transmission Protocol) is a transport layer protocol similar to TCP and UDP, and Nmap can use it to send packets to the target system to determine if it is online and responsive

`sudo nmap 192.168.0.112 -sn --disable-arp-ping -PY` - send ICMP echo request packets to the target IP.

\``sudo nmap 192.168.0.112 -sn --disable-arp-ping -PM` - send ICMP Address Mask Request packets to the target IP.&#x20;

#### Note:

During your Host Discovery phase, remember to turn Wireshark on to capture packets so that you can analyse them later.
