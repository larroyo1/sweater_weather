class RoadtripFacade

  def self.get_directions(from, to)
    directions = RoadtripService.get_directions(from, to)

    if directions[:route][:formattedTime].present?
      Roadtrip.new(directions, from, to)
    else
      directions[:info][:statuscode]
    end
  end
end
