class BackgroundFacade

  def self.get_background(location)
    image = BackgroundService.get_backgrounds(location)

    Background.new(image[:results][0])
  end
end
