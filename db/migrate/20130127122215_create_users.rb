class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :password
      t.string :profile_bg
      t.string :profile_fg
      t.string :profile_image
      t.timestamps
    end
  end
  
  # migrate the users data and add the constant default objects with values
  def change
    add_column :profile_bg => "fff", :profile_fg => "000", :profile_image
  end
  
end
