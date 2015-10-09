class WeatherReportsController < ApplicationController

  def index
    @report = WeatherReport.get_report('Toronto')
  end

  def new
    @weatherman = Weatherman.new
  end

  def show
    @weather_report = WeatherReport.find(params[:id])
    @comment = @weather_report.comments.build
  end

  def create
    @weather_report = WeatherReport.new(weather_report_params)

    if @weatherman.save
      redirect_to weather_reports_url
    else
      render :new
    end
  end
end

#   private
#   def weather_report_params
#     params.require(:post).permit(:title, :body, :author)
#   end
# end
