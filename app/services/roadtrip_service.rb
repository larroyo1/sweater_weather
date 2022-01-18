class RoadtripService

  def self.get_directions(from, to)
    response = conn.get do |faraday|
      faraday.params['from'] = from
      faraday.params['to'] = to
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new('http://www.mapquestapi.com/directions/v2/route') do |faraday|
      faraday.params['key'] = ENV['map_key']
    end
  end
end
