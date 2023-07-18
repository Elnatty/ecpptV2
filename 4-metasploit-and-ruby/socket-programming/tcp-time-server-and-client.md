# TCP time Server and Client

<pre class="language-ruby" data-title="Time_Server_script.rb" data-overflow="wrap" data-line-numbers><code class="lang-ruby">#!/usr/bin/ruby
<strong>require 'socket'
</strong>
ip,port = '127.0.0.1',5000

def main(ip,port)
	# new TCP server bound to ip and port provided as argument
	server = TCPServer.new ip,port
	# loop indefinitely to accept clients requests
	loop do
		# new request accepted (client is a socket)
		client = server.accept
		# prints the client information (IP and port)
		print Time.new.to_s + " - IP: "+client.peeraddr[3]
		print " Port: "+client.peeraddr[1].to_s+"\n"
		# client socket receives a message from the client
		# chop is used to delete the last character ("\n")
		case client.gets.chop
			# the server sends the correct answer according to the
			# type of operation received (timestamp|utc|local)
			when "timestamp" then client.puts(Time.now.to_i)
			when "utc" then client.puts(Time.now.utc)
			when "local" then client.puts(Time.now)
      when "dking" then client.puts("You are communicating with a Time Server")
			else client.puts("Invalid operation")
		end
		# server is done => close the socket
		client.close
	end
end
main(ip, port)

# begin
# 	ip = ARGV[0]
# 	port = ARGV[1]
# 	main(ip,port)
# rescue Exception => e
# 	puts e
# end
</code></pre>

{% code title="Time_Client_script.rb" overflow="wrap" lineNumbers="true" %}
```ruby
#!/usr/bin/ruby
require 'socket'
host,port="127.0.0.1",5000

def main(host,port,type)
	# open the connection with the time server
	# available on host and port arguments
	TCPSocket.open(host,port) do |s|
		# sends to the server the type of time  we want
		s.puts(type)					# (timestamp|utc|local)
		# receives and puts to stdout the formatted time
		puts s.gets
	end
end
main(ARGV[0],ARGV[1],ARGV[2])

# begin
# 	host = ARGV[0]
# 	port = ARGV[1]
# 	type = ARGV[2]
# 	main(host,port,type)
# rescue Exception => e
# 	puts s
# end

# usage: ./client.rb <server_ip> <port> <timestamp or local or utc> 
```
{% endcode %}

