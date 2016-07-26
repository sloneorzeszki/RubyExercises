require 'json'
require 'socket'

server = TCPServer.open(2000)

class Server
	def initialize
		@request_type = nil
	end

	def accept_connection
		client = server.accept
	end

	def fetch_request_type
		request = client.read_nonblock(256)
		request_type = request.split[0]
	end

	def get_request
		unless /\index.html/.match(request).nil?
			index_contents = File.read('index.html')
			client.puts "HTTP/1.0 200 OK"
			client.puts "Date: " + Time.now.ctime
			client.puts "Content-Type: text/html"
			client.puts "Size: " + index_contents.size.to_s
			client.puts
			client.puts index_contents
		else
			client.puts "HTTP/1.0 404 Not Found"
		end
	end

	def post_request
		params = {}
		x = /{.*}/.match(request).to_s
		params = JSON.parse(x)
		puts params['viking']['name']
	#	body = File.read('thanks.html')
	#	body["<%= yield %>"] = params
	#	client.puts body
	end

	def close_connection
		client.close
	end

	def check_request_type(request_type)
		if request_type == "GET"
		elsif request_type == "POST"
		else
			puts "I don't know that request"
		end
	end

end

serv = Server.new
serv.accept_connection