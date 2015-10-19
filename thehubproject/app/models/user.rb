class User < ActiveRecord::Base

  require 'google/apis/gmail_v1'

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
    #THE PATH OF THE GOOGLE_API_CLIENT MAY HAVE TO BE CHANGED.
    google_api_client = Google::Apis::GmailV1::GmailService.new
    google_api_client.authorization = Signet::OAuth2::Client.new({
      client_id: Figaro.env.google_client_id,
      client_secret: Figaro.env.google_client_secret_id,
      access_token: google_authentication.access_token
    })
    return google_api_client
  end

  def gmail_threads
    client = google_client
    gmail_api = Google::Apis::GmailV1::GmailService.new
    results = client.execute!(
      :api_method => gmail_api.list_user_messages('me'),
      :parameters => { :userId => 'me' })
    threads = results.data.threads
  end




  # def instagram_client
  #   instagram_authentication = self.authentications.find_by_provider("instagram")
  #   if instagram_authentication
  #   client = Instagram.client(:access_token => instagram_authentication.oauth)
  #   end
  # end

end
