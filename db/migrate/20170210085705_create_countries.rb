class CreateCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :countries do |t|
			t.string  :name, index: true
      t.string  :iso_name
      t.string  :iso
      t.string  :iso3
      t.integer :numcode
      t.boolean :state_required, default: false, null: false
    	t.boolean :post_code_required, default: false, null: false
      t.boolean :eu
    end
  end
end
