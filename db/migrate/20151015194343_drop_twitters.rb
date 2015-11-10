class DropTwitters < ActiveRecord::Migration
  def change
    drop_table :twitters
  end
end
