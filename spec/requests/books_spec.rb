require 'rails_helper'

RSpec.describe 'Books API' do
  describe 'happy path' do
    before(:each) do
      get '/api/v1/book-search?location=denver,co&quantity=50'
      @results = JSON.parse(response.body, symbolize_names: true)
    end

    it 'returns 200 status code with correct keys' do
      expect(response.status).to eq(200)

      expect(@results[:data][:type]).to eq('books')
      expect(@results[:data].keys).to include(:attributes)
      expect(@results[:data][:attributes].keys).to include(:destination, :forecast, :total_books_found, :books)
      expect(@results[:data][:attributes][:forecast].keys).to include(:summary, :temperature)
      expect(@results[:data][:attributes][:books].count).to eq(50)
      expect(@results[:data][:attributes][:books][0][0].keys).to include(:isbn, :title, :publisher)
    end
  end
end
