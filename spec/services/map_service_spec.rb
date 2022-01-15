require 'rails_helper'

RSpec.describe MapService do
  it 'establishes connection with coordinates' do
    location = MapService.get_location('Denver')
    coordinates = location[:results][0][:locations][0][:latLng]

    expect(location).to be_a(Hash)
    expect(coordinates[:lat]).to eq(39.738453)
    expect(coordinates[:lng]).to eq(-104.984853)
  end
end
