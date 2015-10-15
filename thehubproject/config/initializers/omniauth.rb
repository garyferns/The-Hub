# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :twitter, Figaro.env.tw_consumer_key, Figaro.env.tw_consumer_secret
#
#   provider :google_oauth2, ENV["Figaro.env.google_client_id"], ENV["Figaro.env.google_client_secret_id"] {
#     :scope => "/gmail.readonly"
#     :image_size => "original" # The default is original, but you can change it to square. Pass it a value for pixels
#     }
# end