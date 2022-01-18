class WeatherSerializer
  include JSONAPI::Serializer

  attributes :current_weather, :daily_weather

  attribute :current_weather do |weather|
    weather.current_weather[:datetime] = Time.at(weather.current_weather[:dt]).to_datetime
    weather.current_weather[:temperature] = weather.current_weather[:temp]
    weather.current_weather[:sunrise] = Time.at(weather.current_weather[:sunrise]).to_datetime
    weather.current_weather[:sunset] = Time.at(weather.current_weather[:sunset]).to_datetime
    weather.current_weather[:conditions] = weather.current_weather[:weather][0][:description]
    weather.current_weather[:icon] = weather.current_weather[:weather][0][:icon]

    weather.current_weather.without(:temp, :dt, :weather, :pressure, :dew_point, :clouds, :wind_speed, :wind_deg, :wind_gust)
  end

  attribute :daily_weather do |weather|
    weather.daily_weather.map do |daily_weather|
      {
        date: Time.at(daily_weather[:dt]).to_date,
        sunrise: Time.at(daily_weather[:sunrise]).to_datetime,
        sunset: Time.at(daily_weather[:sunset]).to_datetime,
        max_temp: daily_weather[:temp][:max],
        min_temp: daily_weather[:temp][:min],
        conditions: daily_weather[:weather][0][:description],
        icon: daily_weather[:weather][0][:icon]
      }
    end
  end
end
