class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

private
def not_authenticated
  redirect_to new_user_session_path, alert: "Please login first"
end

end
