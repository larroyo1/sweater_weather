class BooksFacade

  def self.search_books(location, quantity)
    data = BooksService.search_books(location, quantity)

      Books.new(data, quantity)
  end
end
