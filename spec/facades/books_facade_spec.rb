require 'rails_helper'

RSpec.describe BooksFacade do
  it 'creates books poros' do
    books_result = BooksFacade.search_books('Denver', 50)

    expect(books_result).to be_a(Books)
    expect(books_result.books.count).to eq(50)
  end
end
