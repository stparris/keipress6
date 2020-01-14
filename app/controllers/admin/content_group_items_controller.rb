class Admin::ContentGroupItemsController < AdminController
  before_action :set_content_group_item, only: [:show, :edit, :update, :destroy]
  before_action :set_new, only: [:new]

  layout 'admins'

  def sort
    params[:content_group_item].each_with_index do |id, index|
      item = ContentGroupItem.find(id)
      item.update_attribute(:position, index + 1) if item
    end
    render body: nil
  end

  # GET /content_group_items
  # GET /content_group_items.json
  def index
  end

  # GET /content_group_items/1
  # GET /content_group_items/1.json
  def show
  end

  # GET /content_group_items/new
  def new
  end

  # GET /content_group_items/1/edit
  def edit
  end

  # POST /content_group_items
  # POST /content_group_items.json
  def create
    @content_item = ContentGroupItem.new(content_group_item_params)
    respond_to do |format|
      begin
        if @content_item.save!
          flash[:success] = 'Content item was successfully created.'
          format.html { redirect_to admin_content_group_item_url(@content_item) }
          format.json { render :show, status: :created, location: @content_item }
        end
      rescue Exception, ContentGroupItem::ExclusiveArcError => e 
        flash[:danger] = "Error: #{e.message}"
        format.html { render :new }
      end   
    end
  end

  # PATCH/PUT /content_group_items/1
  # PATCH/PUT /content_group_items/1.json
  def update
    respond_to do |format|
      begin
        @content_item.update(content_group_item_params)
        flash[:success] = 'Content item was successfully updated.'
        format.html do
          if params[:set_content_group_text_item]
            redirect_to admin_content_group_text_items_url
          else
            redirect_to admin_content_group_item_url(@content_item) 
          end
        end
        format.json { render :show, status: :ok, location: @content_item }
      rescue Exception, ContentGroupItem::ExclusiveArcError => e 
        flash[:danger] = "Error: #{e.message}"
        format.html { render :edit }
      end   
    end
  end

  # DELETE /content_group_items/1
  # DELETE /content_group_items/1.json
  def destroy
    respond_to do |format|
      begin  
        if @content_item.destroy
          flash[:success] = 'Content item was successfully removed.'
          format.html { redirect_to admin_content_group_url(@content_group) }
          format.json { head :no_content }
        end
      rescue Exception => e 
        flash[:danger] = "Oops! Something went wrong: #{e.message}"
        format.html { render :new }
      end      
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_content_group_item
      @content_item = ContentGroupItem.find(params[:id])
      @content_group = @content_item.content_group
    end

    def set_new
      @content_item = ContentGroupItem.new
      @content_item.content_type = params[:content_type].present? ? params[:content_type] : nil 
      content_id = params[:content_group_id].present? ? params[:content_group_id] : params[:content_id]
      @content_item.content_group = ContentGroup.find(content_id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def content_group_item_params
      params.require(:content_group_item).permit(
        :name,
        :css_classes,
        :content_id,
        :content_type,
        :image_id,
        :carousel_id,
        :image_group_id,
        :medium_id,
        :list_group_id,
        :link_text_id,
        :text_html_flag,
        :body,
        :admin_id,
        :include_admin_handle,
        :include_update_time,
        :include_caption,
        :include_copyright,
        :include_description,
        :position)
    end
end
