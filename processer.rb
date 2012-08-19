class Processer

	def service(request)
		resource_path = request.getPath()
		webapps_path = File.expand_path($0).slice(0..-($0.to_s.length)-1)
		resource_abslute_path = webapps_path + "webapps" + resource_path
		resource = File.exist?(resource_abslute_path) ? File.new(resource_abslute_path) : nil
		resource
	end

end