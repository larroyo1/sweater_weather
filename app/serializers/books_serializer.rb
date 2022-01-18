class BooksSerializer

  def self.get_results(books, location, weather, location_name)
    {
      data: {
        id: nil,
        type: 'books',
        attributes: {
          destination: location_name,
          forecast: {
            summary: weather.current_weather[:weather].first[:description],
            temperature: weather.current_weather[:temp]
          },
          total_books_found: books.total_books,
          books: books.books.map do |book|
            [{
              isbn: book[:isbn],
              title: book[:title],
              publisher: book[:publisher_facet]
            }]
          end
        }
      }
    }
  end
end
