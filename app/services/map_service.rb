class MapService

  def self.get_location(location)
    response = conn.get("address?location=#{location}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new('http://www.mapquestapi.com/geocoding/v1/') do |faraday|
      faraday.params['key'] = ENV['map_key']
    end
  end
end
