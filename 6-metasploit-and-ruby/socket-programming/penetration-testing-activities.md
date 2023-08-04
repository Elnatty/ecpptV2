# Penetration Testing Activities

`sudo gem install net-ping -r` - a gem for sending echo ICMP requests.

{% code overflow="wrap" lineNumbers="true" %}
````ruby
```ruby
require 'net/ping'
host = ARGV[0]
req = Net::Ping::ICMP.new(host)
if req.ping then puts "[+]#{host} is UP."
else puts "[-]#{host} is DOWN."
end

# usage: sudo ./ping.rb <ip>
# if host is down or firewall is blocking pings, we will get no reply.
```
````
{% endcode %}



