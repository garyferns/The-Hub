class EmailController < ApplicationController
  def index
    @email = Email.new('gareth.fernandes7@gmail.com')
    # @email
  end
end
