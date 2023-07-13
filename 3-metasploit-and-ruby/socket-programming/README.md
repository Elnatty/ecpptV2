# Socket Programming



{% code overflow="wrap" lineNumbers="true" %}
```ruby
# https://tf.nist.gov/tf-cgi/servers.cgi - time servers

require 'socket'

=begin

=======================================
TCP Socket Client
=======================================
s = TCPSocket.open("129.6.15.28", 37) # establish a connection with the service.
# or
s = TCPSocket.open("129.6.15.28", 37, "192.168.0.100", 5000) # to specify a custom port.
res = s.gets
int = res.unpack('N') # Decodes str (which may contain binary data).
time = Time.at(int[0]-2208988800)
s.addr true # returns our ip addr, DNS name and port info in an array.
s.peeraddr true # returns same info + DNS name for the remote server.
s.close

# or

time = TCPSocket.open("129.6.15.28", 37) do |s|
  puts Time.at(s.gets.unpack('N')[0] - 2208988800)
end

=======================================
UDP Socket Client
=======================================
s = UDPSocket.new
s.send("", 0, "129.6.15.28", 37) # send an empty packet to the time server.
resp = s.recv(4) # receive time data from the time server.
time = Time.at(resp.unpack('N')[0] - 2208988800) # get the time data.

# sending multiple requests
(1..10).each {|i| res[i] = s.recv(4)}

=end
```
{% endcode %}







