class BeermappingApi

  def self.places_in(city)
city = city.downcase
Rails.cache.fetch(city) { fetch_places_in(city) }
end

private

def self.fetch_places_in(city)
    # this url requires APIKEY env variable to be set:
    # url = "http://beermapping.com/webservice/loccity/#{key}/"
    # alternate url:
    url = 'http://stark-oasis-9187.herokuapp.com/api/'
    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) and places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.inject([]) do | set, place |
      set << Place.new(place)
    end
  end

  def self.key
    raise "APIKEY env variable not defined" if ENV['APIKEY'].nil?
    ENV['APIKEY']
  end
end