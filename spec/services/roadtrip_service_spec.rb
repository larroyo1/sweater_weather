require 'rails_helper'

RSpec.describe RoadtripService do
  it 'establishes successful connection' do
    directions = RoadtripService.get_directions('Denver', 'Aurora, CO')

    expect(directions).to be_a(Hash)
    expect(directions[:route].keys).to include(:formattedTime)
    expect(directions[:route][:formattedTime]).to eq("00:21:02")
  end
end
