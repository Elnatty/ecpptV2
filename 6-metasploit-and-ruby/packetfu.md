# PacketFU

PacketFu is a ruby library for reading and writing packets to a network interface.

It can be used to create packets, sniff, and filter packets.

{% embed url="https://rubyfu.net/module-0x3-or-network-kung-fu/packet-manipulation" %}

{% embed url="https://github.com/packetfu/packetfu" %}

### Full Installation steps

* sudo apt-get install ruby-dev
* sudo apt-get install libpcap-dev
* sem install -r pcaprub
* sudo gem install -r packetfu

#### To check if all went well:

`gem env` - to view its env variables.

`cd /var/lib/gems/3.1.0/gems/packetfu-2.0.0/examples` - navigate into the folder.

`ruby packetfu-shell.rb` - run the file. If (packet capturing/injecting) is enabled, then all is working fine.

{% code overflow="wrap" lineNumbers="true" %}
```ruby
# in "irb" terminal we call the "PacketFu" class using require.
>> require 'packetfu'
>> PacketFu:: # we see many other classes we can use too.
>> include PacketFu # we can use this to avoid calling PacketFu::<class_name> whenever we want to use a class.
# for example the PacketFu::Utils class can be used to get info about our machine Network interfaces.
>> PacketFu::Utils.whoami? # gives info about the default network adapter.
>> Utils.arp("192.168.0.1") # returns mac-addr of the device.
```
{% endcode %}

#### To create Custom Packets, Common packets classes are:

* ARPPacket - constructs ARP packets.
* EthPacket - constructs Ethernet packets.
* ICMPPacket
* IPPacket
* TCPPacket
* UDPPacket

#### Each of the above Classes use suitable Header and Options or flags.

* IPHeader
* ICMPHeader
* TCPHeader
* TCPFlags
* ARPHeader

## 1 - Creating a custom UDP Packet from scratch

reference: [https://www.rubydoc.info/gems/packetfu/1.1.10/PacketFu/UDPPacket](https://www.rubydoc.info/gems/packetfu/1.1.10/PacketFu/UDPPacket)

{% code overflow="wrap" lineNumbers="true" %}
```ruby
## Create a UDP packet to contact and obtain Time request from a Time Server.
>> u = UDPPacket.new
>> ip,port = "129.6.15.28", 37 # ip and port of the time server we want to reach.
# we need the Mac addr of the ip, but its not in our local network, so we will use the mac of our default gateway.

# A - Lets start with the Ethernet Headers.
>> s_ip = Utils.whoami?[:ip_saddr] # specifying source ip addr, which is us.
>> s_mac = Utils.whoami?[:eth_saddr] # our source mac add.
>> g_mac = Utils.whoami?[:eth_daddr] # our dest mac addr (our gateway mac).

# B - UDP Raw packets eth header using the extracted mac addresses.
>> u # view entire packet structure to fill.
>> u.eth_saddr=s_mac # set the source mac addr.
>> u.eth_daddr=g_mac # set the dest mac addr.

# C - Lets fill the IP Header infos.
>> u.ip_saddr = s_ip # set the source ip to our kali ip.
>> u.ip_daddr = ip # set the dest ip addr (time server ip addr).

# D - Finally the UDP src and dst ports.
>> u.udp_src = 5000 # we use a random port number.
>> u.udp_dst = port # the time server uses port 37.

# sending the udp packet.
>> u.recalc
>> u.to_w
# we successfully sent and received the UDP packet below.

# We successfully sent the UDP packet but we get a "Destination Unreachable" ICMP message, why? because we are using "raw sockets", we sent the packet directly to the network without going through the kernel TCP/IP stack.
# This means that in our kernel, we do not have a real socket (bound to UDP source port) that is waiting for a UDP time response.
# An easy trick to avoid the ICMP kernel response is to create an UDP socket which binds itself to our source port. ie, s = UDPSocket.new, s.bind("kali_ip",port).
```
{% endcode %}

<figure><img src="../.gitbook/assets/image (32).png" alt=""><figcaption></figcaption></figure>

## 1b - Shortcut for creating UDP packets quckier.

{% code overflow="wrap" lineNumbers="true" %}
```ruby
>> u = UDPPacket.new
>> u = UDPPacket.new(:config=>Utils.whoami?) # this automatically fills the src/dst mac and src ip with the Util.whoami? values, instead of manually inputting them.
```
{% endcode %}

## 2 - Creating a TCP SYN raw packet

{% code overflow="wrap" lineNumbers="true" %}
```ruby
# We just need to create a TCPPacket, set the Ethernet, IP header fileds, then the TCP header with the correct dst port and SYN flag enabled.
>> t = TCPPacket.new(:config=>Utils.whoami?)
>> t_ip_daddr = "192.168.0.112" # dst ip addr.
>> t_eth_daddr =  Utils.arp(t_ip_daddr) # dst mac addr.
>> t.ip_daddr = t_ip_daddr # set the dst ip addr.
>> t.eth_daddr = t_eth_daddr # set the dst mac addr.
>> t.tcp_sport = 4000 # src port.
>> t.tcp_dport = 80 # dst port.
>> t.tcp_flags.syn = 1 # setting the SYN flag.
>> t.recalc
>> t.to_w # send packet.

# We want our script to be capable of detecting the SYN+ACK. We can use the "Capture" class to sniff every packet received on a specific network interface.

# Now, lets see how to use "capture" to extract all of the TCP packets that have source IP addr equal to <victim_ip> and <victim_port> as source port from the eth0 interface.
>> cap = Capture.new(:iface=>"eth0") # our capture instance.
>> cap.capture(:filter=>"src host 192.168.0.1 and src port 80") # our filter.
>> raw_packet = cap.next # print the result.
>> tcp_paket = Packet.parse raw_packet # view results.
```
{% endcode %}

