class Admin::ListGroupItemsController < AdminController
  before_action :set_list_group_item, only: [:show, :edit, :update, :destroy]
  before_action :set_new, only: [:new]

  layout 'admins'

  def sort
    params[:list_group_item].each_with_index do |id, index|
      item = ListGroupItem.find(id)
      item.update_attribute(:position, index + 1) if item
    end
    render body: nil
  end

  # GET /list_group_items
  # GET /list_group_items.json
  def index
    @list_group_items = ListGroupItem.all
  end

  # GET /list_group_items/1
  # GET /list_group_items/1.json
  def show
  end

  # GET /list_group_items/new
  def new

  end

  # GET /list_group_items/1/edit
  def edit
  end

  # POST /list_group_items
  # POST /list_group_items.json
  def create
    @list_group_item = ListGroupItem.new(list_group_item_params)
    respond_to do |format|
      begin
        if @list_group_item.item_type == 'external_link' || @list_group_item.item_type == 'plain_text'
          @list_group_item.link_text = LinkText.create(link_text_params)
        end
        @list_group_item.save!
        flash[:success] = 'List group item was successfully created.'
        format.html { redirect_to admin_list_group_item_url(@list_group_item) }
        format.json { render :show, status: :created, location: @list_group_item }
      rescue Exception, ListGroupItem::ExclusiveArcError => e
        flash[:danger] = "Error: #{e.message}"
        format.html { render :new }
        format.json { render json: @list_group_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /list_group_items/1
  # PATCH/PUT /list_group_items/1.json
  def update
    respond_to do |format|
      begin 
        @list_group_item.update!(list_group_item_params)
        if @list_group_item.item_type == 'external_link'
          @list_group_item.link_text.update(link_text_params)
        end
        flash[:success] = 'List group item was successfully updated'
        format.html { redirect_to admin_list_group_item_url(@list_group_item) }
        format.json { render :show, status: :ok, location: @list_group_item }
      rescue Exception, ListGroupItem::ExclusiveArcError => e
        flash[:danger] = "Error: #{e.message}"
        format.html { render :edit }
        format.json { render json: @list_group_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /list_group_items/1
  # DELETE /list_group_items/1.json
  def destroy
    @list_group = @list_group_item.list_group
    @list_group_item.destroy
    respond_to do |format|
      flash[:success] = 'List group item was successfully deleted'
      format.html { redirect_to admin_list_group_url(@list_group) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list_group_item
      @list_group_item = ListGroupItem.find(params[:id])
    end

    def set_new
      @list_group_item = ListGroupItem.new
      @list_group_item.item_type = params[:item_type].present? ? params[:item_type] : nil 
      @list_group_item.list_group = ListGroup.find(params[:list_group_id])
      if @list_group_item.item_type && (@list_group_item.item_type == 'external_link' || @list_group_item.item_type == 'plain_text')
        @list_group_item.link_text = @list_group_item.item_type == 'external_link' ? LinkText.new(http_https: 'https') : LinkText.new
      end
    end

    def link_text_params
      params.require(:link_text).permit(:site_id,:http_https,:link,:body,:css_classes,:test_text,:new_window)
    end

    # Never trust parameters from the scary internet, only allow the white list_group through.
    def list_group_item_params
      params.require(:list_group_item).permit(:name,:label,:list_group_id,:css_classes,:item_type,:page_id,:category_id,:link_text_id)
    end
end
