require 'json'
require 'socket'

server = TCPServer.open(2000)

loop {
	client = server.accept
	request = IO.readline(client.gets)
	puts request
	viking_hash = request.slice(request.index("\r\n\r\n")+4..-1) #cut out the hash
	client.puts request.size
	request_type = request.split[0]
  puts request_type
	if request_type == "GET"
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
	elsif request_type == "POST"
		new_user = /{.*}/.match(request)
		params = {}
		params = JSON.parse(new_user)
		body = File.read('thanks.html')
		body["<%= yield %>"] = params
		client.puts body
	else
		puts "I don't know that request"
	end

	client.close
}
