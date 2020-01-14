class CreatePaymentGateways < ActiveRecord::Migration[5.2]
  def change
    create_table :payment_gateways do |t|
    	t.string :name
    	t.references :site
      t.string :mode
    	t.string :gateway_type
    	t.json :config
      t.timestamps
    end

    add_foreign_key :payment_gateways, :sites, on_delete: :cascade
  end
end


