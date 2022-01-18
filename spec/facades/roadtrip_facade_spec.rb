require 'rails_helper'

RSpec.describe RoadtripFacade do
  it 'creates poros successfully' do
    directions = RoadtripFacade.get_directions('Denver', 'Houston')

    expect(directions).to be_a(Roadtrip)
    expect(directions.formatted_travel_time).to eq('15 hours, 38 minutes')
  end
end
