require 'json'
require 'socket'


class Browser
	def initialize(host,port,path)
		@host = host
		@port = port
		@path = path
	end

	def make_connection
		loop do
			request = ask_for_action
			socket = TCPSocket.open(@host, @port)
			socket.puts(request)
			response = socket.read
			puts response
		end
	end

	def ask_for_action
		puts "What do you want to do? [G]ET/[P]OST?"
		user_decision = gets.chomp

		if user_decision.upcase == "G"
			request = "GET #{@path} HTTP/1.0\r\n\r\n"
		elsif user_decision.upcase == "P"
			request = ask_for_post_data
		else
			puts "I don't understand. Exiting."
			exit
		end
		return request
	end

	def ask_for_post_data
		puts "What is the name of the viking?"
		viking_name = gets.chomp
		puts "What is his email?"
		viking_email = gets.chomp
		new_user = {viking: {name: viking_name, email: viking_email}}
		request = "POST #{@path} HTTP/1.0\nContent-Length: " + "#{new_user}".size.to_s + "\r\n\r\n" + new_user.to_json
	end
end

br = Browser.new('localhost',2000,'/index.html')
br.make_connection

#headers, body = response.split("\r\n\r\n", 2)
#puts body
