class User < ActiveRecord::Base

  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes["password"] }
  validates :password, confirmation: true, if: -> { new_record? || changes["password"] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes["password"] }

  validates :email, uniqueness: true

  has_many :authentications, :dependent => :destroy

  def twitter_client
    twitter_authentication = self.authentications.find_by_provider("twitter")
    if twitter_authentication
      twitter = Twitter::REST::Client.new do |config|
        config.consumer_key = Figaro.env.tw_consumer_key
        config.consumer_secret = Figaro.env.tw_consumer_secret
        config.access_token = twitter_authentication.oauth_token
        config.access_token_secret = twitter_authentication.oauth_secret
      end
      return twitter
    end
  end

  def gmail_client
    if gmail_authenitcation
      gmail_authentication = self.authentications.find_by_provider("gmail")
      gmail = Gmail.connect(:xoauth, self.gmail_address,
        :token           => gmail_authentication.oauth_token,
        :secret          => gmail_authentication.oauth_secret,
        :consumer_key    => Figaro.env.google_client_id,
        :consumer_secret => Figaro.env.google_client_secret_id
        )
    end
    return gmail
  end

end
