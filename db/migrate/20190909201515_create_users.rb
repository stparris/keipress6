class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :prefix
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :suffix   
      t.string :locale          
      t.string :hashed_password
      t.string :salt
      t.string :title
      t.string :auth_code
      t.string :auth_code_expiration
      t.string :marketing
      t.string :user_token
      t.references :site
      t.timestamps null: false
    end

    add_foreign_key :users, :sites, on_delete: :cascade
    add_index :users, :email
    add_index :users, :first_name
    add_index :users, :last_name
  
  end
end


