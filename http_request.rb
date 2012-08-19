class HttpRequest

	def initialize(header, net_request)

		@request = Hash.new
		# header = http_request.gets.chop
		declaration = header.split(" ")
		@request["method"] = declaration[0].strip
		@request["path"] = declaration[1].strip
		@request["protocal"] = declaration[2].strip
		while line = net_request.gets
			if line == "\r\n"
				break
			end
			http_field = line.split(":")
			@request[http_field[0]] = http_field[1].strip
		end

	end

	def method_missing(method, *args, &block)
		method = method.id2name
		if method.start_with?("get")
			return @request[method.slice(3..-1).downcase]
		end
	end

	def get_binding
		binding
	end

	def to_s
		@request.to_s
	end

end