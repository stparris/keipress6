class CreateStates < ActiveRecord::Migration[5.2]
  def change
    create_table :states do |t|
      t.string     :name
      t.string     :abbr
      t.references :country
    end
    add_foreign_key :states, :countries, on_delete: :cascade
  end
end
