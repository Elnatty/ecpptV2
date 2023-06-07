# a - Advanced Port Scanning

When we do a normal SYN scan is `sudo nmap -sS 192.168.0.141 -Pn --disable-arp-ping -n -p 80` , we see this in Wireshark, which could be easily blocked by IPS/IDS, FWs etc..

<figure><img src="../.gitbook/assets/image (16).png" alt=""><figcaption></figcaption></figure>

In order to bypass FWs, we can use to nmap -f to fragment packets while sending them to the victim, in which the victim is left to reassemble the packets, this should bypass FWs.

`sudo nmap -f 192.168.0.141 -n -p80 --disable-arp-ping -Pn`&#x20;

<figure><img src="../.gitbook/assets/image (18).png" alt=""><figcaption></figcaption></figure>

As we can see that the 1st 2 packets are being fragmented, the default fragmentation of the header is displayed on the 1st 2 packets, while the SYN scan takes place on the 3rd packet.

We can break the packets into more Fragments, we can use the "--data-length \<number>, for example if we add extra bytes to our payload, we will see more fragments in wireshark.

<figure><img src="../.gitbook/assets/image (25).png" alt=""><figcaption></figcaption></figure>

More fragment may hide our scan from detection.&#x20;

We can also add a 2nd "-f" argument on nmap, which will cause the fragment to become 16bytes instead of the default 8bytes. `sudo nmap -f -f 192.168.0.141 -n -p 80 --disable-arp-ping -Pn` .

### \[Hping]

Hping also provides packet fragmentation. `sudo hping3 -S -f -p 80 192.168.0.141 -c 1` .

### Other ways to evade FWs

#### 1 - By using Decoys:&#x20;

this allows scanning ports at the same time floods IPS logs with useless data, this is possible because we will spoof our address and perform fake scans with their address. We will choose some alive ips in the network, and spoof their address.

`udo nmap -p 80 -D 192.168.0.112,192.168.0.141,ME 192.168.0.141` - we can use the "ME" flag to specify our own ip addr. Decoy scans do not work with TCP connect scan and OS detection scans.

We can also send using RANDOM ips in the network using the "RND:" argument.

`sudo nmap -D RND:10 192.168.0.141 --disable-arp-ping -Pn -p 80` - here we used 10 RANDOM Decoy ips to run the scan.

\[Hping] also offers same feature, `udo hping3 --rand-source -S -p 80 192.168.0.141 -c 3` - this uses random ip addresses to perform the scan on our behalf.

The problem here is that Modern Networks applies filters to limit attacks that uses fake ip's to perform port scans, for this reason we can choose to use an ip addr of a live host in the same subnet. `sudo hping3 -a 192.168.0.254 -S -p 80 192.168.0.141`  - "-a" to specify the decoy address.

#### 2 - DNS

A very popular mistake administrators make is to allow traffic from specific ports without checking if this traffic contains malicious requests, port scans and more. Example DNS (53) is allowed on every network.

`sudo nmap --source-port 53 192.168.0.141 -sS` - scan using our dns port as source.

`sudo hping3 -S -s 53 --scan known 192.168.0.141` - using HPING to scan DNS as our source port.

#### 3 - Appending random data into a packet header

`sudo nmap -sS --data-length 10 -p 21 192.168.141` - appends random data into the header payload.

`udo hping3 -S -p 21 --data 24 192.168.0.141` - using hping to add random data into the payload header.

#### 4 - Mac address Spoofing

`sudo nmap --spoof-mac apple 192.168.0.141 -p 80 -Pn --disable-arp-ping -n` - spoofing an apple device.

`sudo nmap --spoof-mac 192.168.0.141 -p 80 -Pn --disable-arp-ping -n` - use the "0" for random mac addr.

`sudo nmap --spoof-mac 11:22:33:44:55 192.168.0.141 -p 80 -Pn --disable-arp-ping -n` - specifying a mac of our choice.

#### 5 - Randomize the host during scan

We create a host.list with 4 ips inside, then instruct nmap to use this list. `sudo nmap -iL host.list -sS -p 80,443,21,22,135,555 --randomize-hosts` - this technique will have higher results while scanning a target with higher delay, adding a delay on our port scannin will make the scan stealthier.

#### 6 - Delay scan

`sudo nmap -iL host.list -sS -p 80,443,21,22,135,555 --randomize-hosts -T 2 $ip`  - adds the T2  which slows down the scan.

`hping3 -1 --rand-dest 192.168.0.x -I eth0` - the "x" specifies the subnet range to randomize, the "-1"  enables the icmp probes.

