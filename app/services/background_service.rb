class BackgroundService

  def self.get_backgrounds(location)
    response = conn.get('/search/photos') do |faraday|
      faraday.params['query'] = location
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new('https://api.unsplash.com') do |faraday|
      faraday.params['client_id'] = ENV['image_key']
    end
  end
end
