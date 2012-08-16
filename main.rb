require "socket"

server = TCPServer.open("localhost", 5000)
threads = []
loop{

	Thread.new(server.accept) do |http_request|

		first_line = http_request.gets
		Thread.current.kill unless first_line
		request = Hash.new
		# first_line = http_request.gets.chop
		declaration = first_line.split("/")
		request["method"] = declaration[0].strip
		request["protocal"] = declaration[1].strip
		request["version"] = declaration[2].strip
		while line = http_request.gets
			if line == "\r\n"
				break
			end
			http_field = line.split(":")
			request[http_field[0]] = http_field[1].lstrip
		end
		puts request
	end
}