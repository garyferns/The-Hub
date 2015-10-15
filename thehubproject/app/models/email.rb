
require 'gmail'



















# require "open-uri"
# require "json"

# class Email < ActiveRecord::Base

# # This is the url get request
# # The userId is the user's email address. place the actual user ID, in a variable, and then place that in the URL.

#   # The get request URl is:  GET "https://www.googleapis.com/gmail/v1/users/userId/messages"


#   include HTTParty
#     base_uri 'https://www.googleapis.com/gmail/v1/users'

#   def initialize(user_email)
#     @user_email = user_email
#   end


#   def get_email_list
#     @response = self.class.get("/#{@user_email}/messages")
#   end
# end
