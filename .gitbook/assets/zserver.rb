#!/usr/bin/ruby
require 'socket'

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