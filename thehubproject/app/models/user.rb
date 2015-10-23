class User < ActiveRecord::Base

  require 'google/api_client'

  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes["password"] }
  validates :password, confirmation: true, if: -> { new_record? || changes["password"] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes["password"] }

  validates :email, uniqueness: true

  has_many :authentications, dependent: :destroy


  def twitter_client
    twitter_authentication = self.authentications.find_by_provider("twitter")
    if twitter_authentication
      twitter_api_client = Twitter::REST::Client.new do |config|
        config.consumer_key = Figaro.env.tw_consumer_key
        config.consumer_secret = Figaro.env.tw_consumer_secret
        config.access_token = twitter_authentication.access_token
        config.access_token_secret = twitter_authentication.access_secret
      end
      return twitter_api_client
    end
  end


  def facebook_client
    facebook_authentication = self.authentications.find_by_provider("facebook")
    if facebook_authentication
      facebook_api_client = Koala::Facebook::API.new(facebook_authentication.access_token)
      return facebook_api_client
    end
  end

  def google_authentication
    authentications.find_by_provider("google")
  end

def google_client
    # Application name is what you named it in Google Developer Console
    google_api_client = Google::APIClient.new({
      application_name: 'The Hub'
    })
    google_api_client.authorization = Signet::OAuth2::Client.new({
      client_id: Rails.application.secrets.google_consumer_key,
      client_secret: Rails.application.secrets.google_consumer_secret,
      access_token: google_authentication.access_token
    })
    return google_api_client
  end

  def gmail_threads
    client = google_client
    gmail_api = client.discovered_api('gmail', 'v1')
    results = client.execute!(
      :api_method => gmail_api.users.threads.list,
      :parameters => { :userId => 'me' })
    threads = results.data.threads
  end

  def gmail_message(id_number)
    client = google_client
    gmail_api = client.discovered_api('gmail', 'v1')
    batch_results = []

    batch = Google::APIClient::BatchRequest.new do |result|
      batch_results << result
    end

    @gmail_messages = id_number.map do |value|
      batch.add(api_method: gmail_api.users.threads.get, parameters: { :userId => 'me', :id => value })
    end
    client.execute(batch)

    @gmail_messages = batch_results

    @gmail_messages.map do |item|
      item.data.messages[0]
    end
  end









  # def instagram_client
  #   instagram_authentication = self.authentications.find_by_provider("instagram")
  #   if instagram_authentication
  #   client = Instagram.client(:access_token => instagram_authentication.oauth)
  #   end
  # end

end
