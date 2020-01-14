class CreateMailTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :mail_templates do |t|
    	t.string :name
    	t.references :site
      t.string :from_email
    	t.string :subject
      t.string :recipient_type
      t.string :template_type
      t.string :locale
    	t.string :body_html
    	t.string :body_text
      t.timestamps
    end
    add_foreign_key :mail_templates, :sites, on_delete: :cascade
  end
end

