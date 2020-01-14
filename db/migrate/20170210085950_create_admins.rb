class CreateAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :admins do |t|
    	t.string :email
      t.string :prefix
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :suffix
      t.string :handle
    	t.string :title
    	t.string :phone
    	t.text :bio
    	t.string :hashed_password
    	t.string :salt
    	t.integer :status
      t.string :admin_type, null: false 
     	t.integer :role,   default: 2
     	t.string :admin_token   	
      t.timestamps null: false
    end

    add_index :admins, :email, unique: true
    add_index :admins, :first_name
    add_index :admins, :last_name
    add_index :admins, :handle, unique: true
  end
end
