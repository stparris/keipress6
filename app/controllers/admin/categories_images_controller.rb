class Admin::CategoriesImagesController < AdminController

	before_action :set_categoery_image, only: [:destroy]

	def create
		@category_image = CategoriesImage.where(category_image_params).first_or_create
		respond_to do
			forrmat.js 
		end
	end

	def destroy
		@category_image.destroy
		respond_to do
			forrmat.js 
		end
	end

	private
		
		def set_category_image
			@category_image = CategoriesImage.find(category_image_params)
		end

		# Never trust parameters from the scary internet, only allow the white list through.
    def category_image_params
      params.require(:category_image).permit(:category_id,:image_id)
    end


end