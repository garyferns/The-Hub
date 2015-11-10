require "open-uri"
require "json"


class WeatherReport
  include HTTParty
  base_uri 'api.openweathermap.org/data/2.5'


  def initialize(city)
    @city = city
  end

  def city_name
    @city
  end

  def get_report
    @response = self.class.get("/weather?q=#{@city}&APPID=#{ENV["weather_key"]}")
  end

  def current_temp
     c_temp = @response['main']['temp']
     (c_temp - 273.15).ceil
  end

  def max_temp
     max_temp = @response['main']['temp_max']
     (max_temp - 273.15).ceil
  end

  def min_temp
     min_temp = @response['main']['temp_min']
     (min_temp - 273.15).ceil
  end

  def cloud_cover
    clouds = @response["clouds"]["all"]

    if (clouds < 30)
      return "sunny"
    elsif (30 >= clouds && clouds < 60)
      return "partially cloudy"
    else
      return "cloudy"
    end
  end

  def complete_info
    @response
  end

end
