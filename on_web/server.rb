require 'json'
require 'socket'

server = TCPServer.open(2000)

loop {
	client = server.accept
	request = client.gets
	request_type = request.split[0]
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
	client.close
}
