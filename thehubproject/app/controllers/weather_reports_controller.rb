class WeatherReportsController < ApplicationController

  def index

    @weather_report = WeatherReport.new('Toronto')
    @weather_report.get_report
  end
end

  # private
  # def weather_report_params
  #   params.require(:post).permit(:city)
  # end