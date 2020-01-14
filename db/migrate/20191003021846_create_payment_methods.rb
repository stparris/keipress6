class CreatePaymentMethods < ActiveRecord::Migration[5.2]
  def change
    create_table :payment_methods do |t|
    	t.string :name
    	t.string :locale
    	t.references :site
    	t.references :payment_type
    	t.boolean :active, default: true, null: false 
      t.string :button_text
    	t.text :instructions
      t.text :summary_page_html
      t.integer :user_mail_template_id
      t.integer :admin_mail_template_id
      t.timestamps
    end

    add_foreign_key :payment_methods, :sites, on_delete: :cascade
    add_foreign_key :payment_methods, :payment_types, on_delete: :cascade
    add_foreign_key :payment_methods, :mail_templates, column: :user_mail_template_id, on_delete: :nullify
    add_foreign_key :payment_methods, :mail_templates, column: :admin_mail_template_id, on_delete: :nullify
  end
end
