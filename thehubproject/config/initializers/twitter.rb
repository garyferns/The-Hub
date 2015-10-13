$twitter = Twitter::REST::Client.new do |config|
  config.consumer_key = Figaro.env.twitter.consumer_key
  config.consumer_secret = Figaro.env.twitter.consumer_secret
  config.access_token = Figaro.env.twitter.access_token
  config.access_token_secret = Figaro.env.twitter.access_token_secret
end