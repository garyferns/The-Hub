Instagram.configure do |config|

  config.client_id = Figaro.env.instagram.config_client_id

  config.access_token = Figaro.env.instagram.config_access_token

end