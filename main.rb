require "socket"
require_relative "http_request"
require_relative "processer"

server = TCPServer.open("localhost", 5000)
threads = []
loop{

	Thread.new(server.accept) do |net_request|

		first_line = net_request.gets
		Thread.current.kill unless first_line
		http_request = HttpRequest.new(first_line, net_request)
		processer = Processer.new
		resource = processer.service(http_request)
		resource.each do |line|
			net_request.puts line
		end
		net_request.close
	end
}

