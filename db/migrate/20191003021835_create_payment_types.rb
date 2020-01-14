class CreatePaymentTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :payment_types do |t|
    	t.string :name
    	t.string :payment_type
    	t.references :site
    	t.references :payment_gateway, default: :null
      t.boolean :show_email, default: true, null: false 
      t.boolean :require_email, default: true, null: false 
      t.boolean :show_user_names, default: false, null: false 
      t.boolean :require_user_names, default: false, null: false 
      t.boolean :show_primary_address, default: false, null: false 
      t.boolean :require_card_address, default: false, null: false 
      t.boolean :require_billing_address, default: false, null: false 
      t.boolean :require_shipping_address, default: false, null: false 
      t.timestamps
    end

    add_foreign_key :payment_types, :payment_gateways, on_delete: :nullify
    add_foreign_key :payment_types, :sites, on_delete: :cascade
  end
end
