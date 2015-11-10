class RenameOauthColumnsInAuthentications < ActiveRecord::Migration
  def change
    rename_column :authentications, :oauth_token, :access_token
    rename_column :authentications, :oauth_secret, :access_secret
  end
end
