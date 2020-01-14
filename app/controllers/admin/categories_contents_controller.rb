class Admin::CategoriesContentsController < AdminController

	before_action :set_categoery_content, only: [:destroy]

	def create
		@category_content = CategoriesContent.where(category_content_params).first_or_create
		respond_to do
			forrmat.js 
		end
	end

	def destroy
		@category_content.destroy
		respond_to do
			forrmat.js 
		end
	end

	private
		
		def set_category_content
			@category_content = CategoriesContent.find(category_content_params)
		end

		# Never trust parameters from the scary internet, only allow the white list through.
    def category_content_params
      params.require(:category_content).permit(:category_id,:content_id)
    end


end