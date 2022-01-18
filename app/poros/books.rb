class Books
  attr_reader :total_books, :books

  def initialize(data, quantity)
    @total_books = data[:numFound]
    @books = data[:docs].first(quantity.to_i)
  end
end
