class CreateUserAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :user_addresses do |t|
      t.string     :name
      t.string     :address1
      t.string     :address2
      t.string     :city
      t.string     :post_code
      t.string     :phone
      t.string     :alternative_phone
      t.references :user
      t.references :state
      t.references :country
      t.timestamps null: false
    end

    add_foreign_key :user_addresses, :users, on_delete: :cascade
    add_foreign_key :user_addresses, :countries, on_delete: :nullify
    add_foreign_key :user_addresses, :states, on_delete: :nullify
  end
end
