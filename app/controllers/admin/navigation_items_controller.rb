class Admin::NavigationItemsController < AdminController
  before_action :set_navigation_item, only: [:show, :edit, :update, :destroy]
  before_action :set_new, only: [:new]

  layout 'admins'

  def sort
    params[:navigation_item].each_with_index do |id, index|
      item = NavigationItem.find(id)
      item.update_attribute(:position, index + 1) if item
    end
    render body: nil
  end

  # GET /navigation_items
  # GET /navigation_items.json
  def index
    @navigation_items = NavigationItem.all
  end

  # GET /navigation_items/1
  # GET /navigation_items/1.json
  def show
  end

  # GET /navigation_items/new
  def new

  end

  # GET /navigation_items/1/edit
  def edit
  end

  # POST /navigation_items
  # POST /navigation_items.json
  def create
    respond_to do |format|
      @navigation_item = NavigationItem.new(navigation_item_params)
      if params[:link_text].present?
        @navigation_item.link_text = LinkText.create!(link_text_params)
      end
      if params[:dropdown].present?
        @navigation_item.dropdown = Dropdown.create!(dropdown_params)
      end
      if @navigation_item.save
        flash[:success] = 'Navigation item was successfully created.'
        if @navigation_item.dropdown
          format.html { redirect_to new_admin_dropdown_item_url(dropdown_id: @navigation_item.dropdown_id) }
        else
          format.html { redirect_to admin_navigation_item_url(@navigation_item) }
        end
        format.json { render :show, status: :created, location: @navigation_item }
      else
        format.html { render :new }
        format.json { render json: @navigation_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /navigation_items/1
  # PATCH/PUT /navigation_items/1.json
  def update
    respond_to do |format|
      if params[:link_text].present?
        @navigation_item.link_text.update!(link_text_params)
      end
      if params[:dropdown].present?
        @navigation_item.dropdown.update!(dropdown_params)
      end
      if @navigation_item.update(navigation_item_params)
        flash[:success] = 'Navigation item was successfully updated'
        if @page
          format.html { redirect_to admin_page_url(@page) }
        else
          format.html { redirect_to admin_navigation_item_url(@navigation_item) }
        end
        format.json { render :show, status: :ok, location: @navigation_item }
      else
        format.html { render :edit }
        format.json { render json: @navigation_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /navigation_items/1
  # DELETE /navigation_items/1.json
  def destroy
    @navigation = @navigation_item.navigation
    @navigation_item.destroy
    respond_to do |format|
      flash[:success] = 'Navigation item was successfully deleted'
      format.html { redirect_to admin_navigation_url(@navigation) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_navigation_item
      @navigation_item = NavigationItem.find(params[:id])
    end

    def set_new
      @navigation = Navigation.find(params[:navigation_id])
      @navigation_item = NavigationItem.new
      @navigation_item.navigation = @navigation
      @navigation_item.item_type = params[:item_type].present? ? params[:item_type] : nil
      @link_text = LinkText.new(site_id: @site.id,link: 'https://',http_https: 'https') if @navigation_item.item_type && @navigation_item.item_type =~ /external/
      @dropdown = Dropdown.new(site_id: @site.id) if @navigation_item.item_type && @navigation_item.item_type =~ /dropdown/
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def navigation_item_params
      params.require(:navigation_item).permit(:name,:label,:navigation_id,:css_classes,:item_type,:page_id,:category_id,:link_text_id,:dropdown_css)
    end

    def link_text_params
      params.require(:link_text).permit(:site_id,:link,:body,:css_classes,:http_https,:new_window,:test_text)
    end

    def dropdown_params
      params.require(:dropdown).permit(:site_id,:name,:css_classes,:nav_type)
    end


end
