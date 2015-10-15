class UserSessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    #puts "----------------"
    #puts request.env['omniauth.auth']
    #puts "----------------"

    if @user = login(params[:email], params[:password])
      redirect_back_or_to(root_path, notice: 'Login successful')
    else
      flash.now[:alert] = 'Login failed'
      render action: 'new'
    end
  end

  def destroy
    session.clear
    puts "*************"
    puts
    puts "*************"

    redirect_to new_user_session_path
  end

end
