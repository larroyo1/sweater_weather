class Background
  attr_reader :id, :description, :image_url, :logo

  def initialize(data)
    @id = nil
    @description = data[:description]
    @image_url = data[:urls][:regular]
    @logo = 'https://unsplash.com/blog/content/images/max/2560/1-VnKoValwGK3-d1bZhD6sVA.jpeg'
  end
end
