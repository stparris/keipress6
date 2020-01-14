class Admin::DropdownItemsController < AdminController
  before_action :set_dropdown_item, only: [:show, :edit, :update, :destroy]
  before_action :set_new, only: [:new]
 
  layout 'admins'

  def sort
    params[:dropdown_item].each_with_index do |id, index|
      item = DropdownItem.find(id)
      item.update_attribute(:position, index + 1) if item
    end
    render body: nil
  end

  # GET /dropdown_items
  # GET /dropdown_items.json
  def index
    @dropdown_items = DropdownItem.all
  end

  # GET /dropdown_items/1
  # GET /dropdown_items/1.json
  def show
  end

  # GET /dropdown_items/new
  def new

  end

  # GET /dropdown_items/1/edit
  def edit
  end

  # POST /dropdown_items
  # POST /dropdown_items.json
  def create
    @dropdown_item = DropdownItem.new(dropdown_item_params)
    respond_to do |format|
      begin
        if @dropdown_item.item_type == 'external_link'
          @dropdown_item.link_text = LinkText.create(link_text_params)
        end
        @dropdown_item.save!
        flash[:success] = 'dropdown item was successfully created.'
        format.html { redirect_to admin_dropdown_item_url(@dropdown_item) }
        format.json { render :show, status: :created, location: @dropdown_item }
      rescue Exception, DropdownItem::ExclusiveArcError => e
        flash[:danger] = "Error: #{e.message}"
        format.html { render :new }
        format.json { render json: @dropdown_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dropdown_items/1
  # PATCH/PUT /dropdown_items/1.json
  def update
    respond_to do |format|
      begin 
        @dropdown_item.update(dropdown_item_params)
        if @dropdown_item.item_type == 'external_link'
          @dropdown_item.link_text.update!(link_text_params)
        end        
        flash[:success] = 'Dropdown item was successfully updated'
        format.html { redirect_to admin_dropdown_item_url(@dropdown_item) }
        format.json { render :show, status: :ok, location: @dropdown_item }
      rescue Exception, DropdownItem::ExclusiveArcError => e
        flash[:danger] = "Error: #{e.message}"
        format.html { render :edit }
        format.json { render json: @dropdown_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dropdown_items/1
  # DELETE /dropdown_items/1.json
  def destroy
    @dropdown = @dropdown_item.dropdown
    @dropdown_item.destroy
    respond_to do |format|
      flash[:success] = 'dropdown item was successfully deleted'
      format.html { redirect_to admin_dropdown_url(@dropdown) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dropdown_item
      @dropdown_item = DropdownItem.find(params[:id])
    end

    def set_new
      @dropdown = Dropdown.find(params[:dropdown_id])
      @dropdown_item = DropdownItem.new
      @dropdown_item.item_type = params[:item_type].present? ? params[:item_type] : nil 
      @dropdown_item.dropdown = @dropdown
      if @dropdown_item.item_type && (@dropdown_item.item_type == 'external_link')
        @dropdown_item.link_text = @dropdown_item.item_type == 'external_link' ? LinkText.new(http_https: 'https') : LinkText.new
      end
    end

    def link_text_params
      params.require(:link_text).permit(:site_id,:http_https,:link,:body,:css_classes,:test_text,:new_window)
    end

    # Never trust parameters from the scary internet, only allow the white dropdown through.
    def dropdown_item_params
      params.require(:dropdown_item).permit(:name,:label,:dropdown_id,:css_classes,:item_type,:page_id,:category_id,:link_text_id,:dropdown_item_css)
    end
end
