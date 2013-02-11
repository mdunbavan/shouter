class CreateUsersShouts < ActiveRecord::Migration
  def up
	create_table :users_shouts, :id => false do |t|
	t.integer :user_id, :null => false
	t.integer :shout_id, :null => false
  end  
  # add index to optimize speed
  add_index :users_shouts, [:user_id, :shout_id], :unique => true
  end
  def down
    remove_index :users_shouts, :column => [:user_id, :shout_id]
    drop_table :users_shouts
  end
end
