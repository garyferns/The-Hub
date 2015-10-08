class WeatherReportsController < ApplicationController

  def index
    @report = WeatherReport.get_report('Toronto')
  end

  def new
    @weatherman = Weatherman.new
  end

  def show
    @weatherman = Weatherman.find(params[:id])
    @comment = @weatherman.comments.build
  end

  def create
    @weatherman = Weatherman.new(weatherman_params)

    if @weatherman.save
      redirect_to weathermans_url
    else
      render :new
    end
  end
end
#   private
#   def post_params
#     params.require(:post).permit(:title, :body, :author)
#   end
# end
