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



#   skip_before_filter :require_login

#   # sends the user on a trip to the provider,
#   # and after authorizing there back to the callback url.
#   def oauth
#     login_at(params[:provider])
#   end

#   def callback
#     # NOTE - will return nil if authentication already exists for current user & provider
#     authentication = add_provider_to_user(params[:provider])
#     if authentication.blank?
#       authentication = current_user.authentications.find_by_provider(params[:provider])
#     end
#     if authentication
#       authentication.oauth_token = params[:oauth_token]
#       authentication.oauth_secret = params[:oauth_verifier]
#       authentication.save
#     end
#     redirect_to root_path, notice: "Authenticated with #{params[:provider]}!"
#   end

#   #example for Rails 4: add private method below and use "auth_params[:provider]" in place of
#   #"params[:provider] above.

#   private

#   def auth_params
#     params.permit(:code, :provider)
#   end

# end
