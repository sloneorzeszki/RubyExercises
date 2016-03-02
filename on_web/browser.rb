require 'socket'

host = 'localhost'
port = 2000
path = "/index.html"

puts "What do you want to do? [G]ET/[P]OST?"
user_decision = gets.chomp

if user_decision.upcase == "G"
	request = "GET #{path} HTTP/1.0\r\n\r\n"
elsif user_decision.upcase == "P"
	puts "Give us some more details."
	puts "What is the name of the viking?"
	viking_name = gets.chomp
	puts "What is his email?"
	viking_email = gets.chomp
else 
	puts "I don't understand. Exiting."
	exit
end


	socket = TCPSocket.open(host, port)
	socket.print(request)
response = socket.read
puts response

#headers, body = response.split("\r\n\r\n", 2)
#puts body
