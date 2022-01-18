class BooksService

  def self.search_books(location, quantity)
    response = conn.get do |faraday|
      faraday.params['q'] = location
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new('http://openlibrary.org/search.json?')
  end
end
