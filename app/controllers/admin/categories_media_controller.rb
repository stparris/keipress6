class Admin::CategoriesMediaController < AdminController
	before_action :set_categoery_nedium, only: [:destroy]

	def create
		@category_medium = CategoriesMedium.where(category_medium_params).first_or_create
		respond_to do
			forrmat.js 
		end
	end

	def destroy
		@category_medium.destroy
		respond_to do
			forrmat.js 
		end
	end

	private
		
		def set_category_medium
			@category_medium = CategoriesMedium.find(category_medium_params)
		end

		# Never trust parameters from the scary internet, only allow the white list through.
    def category_medium_params
      params.require(:category_medium).permit(:category_id,:medium_id)
    end

end