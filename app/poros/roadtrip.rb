class Roadtrip
  attr_reader :id, :time_to_travel, :from, :to

  def initialize(data, from, to)
    @time_to_travel = data[:route][:formattedTime]
    @from = from
    @to = to
    @id = nil
  end

  def formatted_travel_time
    "#{@time_to_travel[0..1]} hours, #{@time_to_travel[3..4]} minutes"
  end
end
