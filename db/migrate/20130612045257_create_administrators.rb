class CreateAdministrators < ActiveRecord::Migration
  def change
    create_table :administrators do |t|
      t.string :fullname
	  t.string :username
	  t.string :password_digest
	  t.string :remember_token
	
      t.timestamps
    end
  end
end
