require 'rails_helper'

RSpec.describe BackgroundFacade do
  it 'creates background poros' do
    image = BackgroundFacade.get_background('Denver, CO')

    expect(image).to be_a(Background)
    expect(image.id).to be(nil)
    expect(image.description).to eq('Community in Denver.')
    expect(image.image_url).to_not be(nil)
    expect(image.logo).to eq('https://unsplash.com/blog/content/images/max/2560/1-VnKoValwGK3-d1bZhD6sVA.jpeg')
  end
end
