require 'rails_helper'

RSpec.describe BooksService do
  it 'establishes connection and returns results' do
    results = BooksService.search_books('Denver', 3)
    
    expect(results).to be_a(Hash)
    expect(results.keys).to include(:numFound, :docs)
    expect(results[:docs].first[:title]).to eq('Denver')
  end
end
