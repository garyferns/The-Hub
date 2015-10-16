class WeatherReportsController < ApplicationController

  def index
<<<<<<< HEAD
    @weather_report = WeatherReport.new('Toronto')
=======
    @weather_report = WeatherReport.new("Toronto")
>>>>>>> Gmail_Integration
    @weather_report.get_report
  end
end

  # private
  # def weather_report_params
  #   params.require(:post).permit(:city)
  # end