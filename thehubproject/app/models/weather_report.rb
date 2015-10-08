require "open-uri"
require "json"



class WeatherReport
  include HTTParty
  base_uri 'api.openweathermap.org/data/2.5'

  def initialize(response)
    @response = response
  end

  def self.get_report(city)
    new(get("/weather?q=#{city}"))
  end

  def current_temp
     temp = @response['main']['temp']
     (temp - 273.15).ceil
  end


end






#   base_uri 'lcboapi.com'

#   def self.all
#     get('/products')['result']
#   end

#   def self.find(product_id)
#     get("/products/#{product_id}")['result']
#   end

#  def get_weather
#    get('/weather?q=#{city_name},#{country_name = ''}')['result']
#  end
# end

# binding.pry