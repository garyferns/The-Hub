class DropInstagrams < ActiveRecord::Migration
  def change
    drop_table :instagrams
  end
end
