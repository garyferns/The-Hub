class InstagramController < ApplicationController



  def index
    @instagram = Instagram.user_recent_media(“19d4af5b10714b11ad1489c69fe059ac”)
  end


end
