require 'rails_helper'

RSpec.describe BackgroundService do
  it 'establishes connection' do
    images = BackgroundService.get_backgrounds('Denver, CO')

    expect(images).to be_a(Hash)
    expect(images[:results][0][:urls].keys).to include(:regular)
  end
end
