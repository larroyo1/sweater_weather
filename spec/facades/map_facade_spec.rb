require 'rails_helper'

RSpec.describe MapFacade do
  it 'creates location poros' do
    coordinates = MapFacade.get_coordinates('Denver, CO')

    expect(coordinates).to be_a(Location)
    expect(coordinates.lat).to eq(39.738453)
    expect(coordinates.long).to eq(-104.984853)
  end
end
