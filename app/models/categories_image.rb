class CategoriesImage < ApplicationRecord
	belongs_to :category
	belongs_to :image

  def self.categories(site_id)
    Category.find_by_sql("select * from categories where site_id = #{site_id} and id in (select distinct category_id from categories_images) order by name asc")
  end
end
