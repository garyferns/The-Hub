class OauthsController < ApplicationController

 skip_before_filter :require_login

  def oauth
    login_at(params[:provider])
  end

  def callback

    add_provider_to_user(params[:provider])
    auth = current_user.authentications.find_by_provider(params[:provider])
    if auth
      auth.access_token = @access_token.token
      auth.access_secret = @access_token.secret if params[:provider] == "twitter"
      auth.save
      notice = "Linked up with #{params[:provider]}!"
    end
    redirect_to user_path(current_user), notice: notice
  end


  private

  def auth_params
    params.permit(:code, :provider)
  end

end
