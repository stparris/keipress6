class ImageOptimizationSettings < ActiveRecord::Migration[5.2]
  def change
  	add_column :images, :max_width, :string
  	add_column :images, :quality, :string
  end
end
