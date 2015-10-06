class UsersController < ApplicationController
  def index
    @user = User.all
  end

  def new
    @user = User.new
  end

  def create
    user = User.new

    if user.save
      redirect_to root_path
    else
      render :new
    end
  end

end
