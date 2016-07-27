require 'json'
require 'socket'



class Server
	def initialize
		@request_type = nil
		@server = TCPServer.open(2000)
		@client = nil
	end

	#wait for connection, once got one - decide on what to do based on the input, loop
	def accept_connection
		loop do
			@client = @server.accept
			self.choose_action
		end
	end
	
	#decide what to do depending if it's GET or POST request, no 'else' closure as other options are already limited on browser side
	def choose_action
		request = @client.read_nonblock(256)
		request_type = request.split[0]
		
		if request_type == "GET"
			self.get_request(request)
		elsif request_type == "POST"
			self.post_request(request)
		end
	end

	#action to perform if GET request arrived - display index.html website 
	def get_request
		unless /\index.html/.match(request).nil?
			index_contents = File.read('index.html')
			@client.puts "HTTP/1.0 200 OK"
			@client.puts "Date: " + Time.now.ctime
			@client.puts "Content-Type: text/html"
			@client.puts "Size: " + index_contents.size.to_s
			@client.puts
			@client.puts index_contents
		else
			@client.puts "HTTP/1.0 404 Not Found"
		end
	end

	#action to perform if POST request arrived - display thanks.html website with the posted values
	def post_request(request)
		fetched_hash = /{.*}/.match(request).to_s
		params = {}
		params = JSON.parse(fetched_hash)
		puts params['viking']['name']
		body = File.read('thanks.html')
		body["<%= yield %>"] = params
		@client.puts body
	end

	def close_connection
		client.close
	end
end

serv = Server.new
serv.accept_connection