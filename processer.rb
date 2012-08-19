class Processer

	FILE_NOT_FOUND = File.expand_path($0).slice(0..-($0.to_s.length)-1) + "webapps/resources/file_not_found.html"

	def service(request)
		resource_path = request.getPath()
		template_file = route(resource_path)

		if File.exist?(template_file)
			template = File.new(template_file).read
		else
			template = File.new(FILE_NOT_FOUND).read
		end
		app_instance = ERB.new(template)
		response = app_instance.result(request.get_binding)
	end

	def route(resource_path)
		webapps_path = File.expand_path($0).slice(0..-($0.to_s.length)-1)
		path = webapps_path + "webapps" + resource_path
		path << ".rhtml" unless resource_path.include?(".")
		return path
	end

end