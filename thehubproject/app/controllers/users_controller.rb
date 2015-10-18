
class UsersController < ApplicationController

  before_action :require_login, except: [:new, :create]

  def index
    @user = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save && login(user_params[:email], user_params[:password])
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    @user.update!(user_params)
    redirect_to root_path
  end



  def show

    client = current_user.twitter_client
    if client
      @mentions = client.mentions_timeline
      @user_timeline = client.user_timeline
      @direct_messages = client.direct_messages
    end


    face_client = current_user.facebook_client
    if face_client
      @facebook_profile = face_client.get_object("me")
      @feed = face_client.get_connections("me", "feed")
    end


    @weather_report = WeatherReport.new("Tokyo")

    @weather_report.get_report

  end



  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name)
  end

end
