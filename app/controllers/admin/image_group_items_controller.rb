class Admin::ImageGroupItemsController < AdminController
  before_action :set_image_group_item, only: [:show, :edit, :update, :destroy]
  before_action :set_new, only: [:new]
   before_action :set_image_group, only: [:edit_all]

  layout 'admins'

  def sort
    params[:image_group_item].each_with_index do |id, index|
      item = ImageGroupItem.find(id)
      item.update_attribute(:position, index + 1) if item
    end
    render body: nil
  end

  # GET /image_group_items
  # GET /image_group_items.json
  def index
  end

  # GET /image_group_items/1
  # GET /image_group_items/1.json
  def show
  end

  # GET /image_group_items/new
  def new

  end

  # GET /image_group_items/1/edit
  def edit
  end

  def edit_all
  end

  # POST /image_group_items
  # POST /image_group_items.json
  def create
    respond_to do |format|
      begin
        @image_group_item = ImageGroupItem.new(image_group_item_params)
        @image_group = @image_group_item.image_group
        if @image_group_item.category_id
          flash[:success] = 'Image group items were successfully created.'
          category = Category.find(@image_group_item.category_id)
          logger.info "category #{category.name}"
          category.images.each do |image|
            logger.info "image #{image.name}"
            ImageGroupItem.where(image_group_id: @image_group.id,image_id: image.id,name: image.name,caption: image.caption).first_or_create
          end
          format.html { redirect_to edit_all_admin_image_group_items_url(image_group_id: @image_group.id) }
        else
          @image_group_item.name = @image_group_item.image.name
          @image_group_item.caption = @image_group_item.image.caption
          @image_group_item.body = @image_group_item.image.description
          if @image_group_item.save
            flash[:success] = 'Image group item was successfully created.'
            format.html { redirect_to admin_image_group_item_url(@image_group_item) }
            format.json { render :show, status: :created, location: @image_group_item }
          end
        end
      rescue Exception => e
        flash[:danger] = "Oops! Something went wrong: #{e.message}"
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /image_group_items/1
  # PATCH/PUT /image_group_items/1.json
  def update
    respond_to do |format|
      if @image_group_item.update(image_group_item_params)
        flash[:success] = 'Image group item was successfully updated.'
        format.html { redirect_to admin_image_group_item_url(@image_group_item) }
        format.js
        format.json { render :show, status: :ok, location: @image_group_item }
      else
        format.html { render :edit }
        format.js
        format.json { render json: @image_group_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /image_group_items/1
  # DELETE /image_group_items/1.json
  def destroy
    @image_group_item.destroy
    respond_to do |format|
      flash[:success] = 'Image group item was successfully deleted.'
      format.html { redirect_to admin_image_group_url(@image_group) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def set_new
      @image_group = ImageGroup.find(params[:image_group_id])
      @image_group_item = ImageGroupItem.new(image_group_id: @image_group.id)
      @new_from_category = true if params[:new_from_category]
    end

    def set_image_group
      @image_group = ImageGroup.find(params[:image_group_id])
    end

    def set_image_group_item
      @image_group_item = ImageGroupItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_group_item_params
      params.require(:image_group_item).permit(
        :name,
        :caption,
        :body,
        :image_group_id,
        :image_id,
        :css_classes,
        :category_id)
    end
end
