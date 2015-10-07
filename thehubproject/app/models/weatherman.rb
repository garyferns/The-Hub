require "open-uri"
require "json"

class WeatherMan
  def self.get_weather
    current_weather = open(URI.parse("http://api.openweathermap.org/data/2.5/weather?lat=35&lon=139"))
    weatherhash = JSON.parse(current_weather.read)
    weatherhash['weather']
  end
end