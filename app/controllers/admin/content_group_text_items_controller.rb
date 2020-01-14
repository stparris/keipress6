class Admin::ContentGroupTextItemsController < AdminController
  before_action :set_content_group_text_item, only: [:edit]
  
  layout 'admins'

  # GET /content_group_text_items
  # GET /content_group_text_items.json
  def index
    @contents = Content.site_text_items(@site.id)
  end
 
  # GET /content_group_text_items/1/edit
  def edit
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_content_group_text_item
      @content_group_text_item = ContentGroupItem.find(params[:id])     
    end
end
