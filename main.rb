require "socket"
require "erb"
require_relative "http_request"
require_relative "processer"

server = TCPServer.open("localhost", 5000)
Thread.abort_on_exception = true

loop{

	Thread.new(server.accept) do |net_request|

		first_line = net_request.gets
		Thread.current.kill unless first_line
		http_request = HttpRequest.new(first_line, net_request)
		processer = Processer.new
		response = processer.service(http_request)
		net_request.puts response
		net_request.close
	end
}

