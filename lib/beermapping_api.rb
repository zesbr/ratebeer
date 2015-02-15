class BeermappingApi

	def self.places_in(city)
		url = "http://beermapping.com/webservice/loccity/#{key}/"
		response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
		places = response.parsed_response["bmp_locations"]["location"]
		return [] if places.is_a?(Hash) and places['id'].nil?
		places = [places] if places.is_a?(Hash)
		places.inject([]) do | set, place |
			set << Place.new(place)
		end
	end

	def self.key
		"96ce1942872335547853a0bb3b0c24db"
	end
end