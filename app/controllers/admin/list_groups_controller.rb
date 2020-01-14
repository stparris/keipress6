class Admin::ListGroupsController < AdminController
  before_action :set_list_group, only: [:show, :edit, :update, :destroy]
  before_action :set_list_type, only: [:new] 

  layout 'admins'

  # GET /list_group_
  # GET /list_group_.json
  def index
    @list_groups = @site.list_groups
  end

  # GET /list_group_/1
  # GET /list_group_/1.json
  def show
    @list_group_items = @list_group.list_group_items
  end

  # GET /list_group_/new
  def new
  end

  # GET /list_group_/1/edit
  def edit
  end

  # POST /list_group_
  # POST /list_group_.json
  def create
    @list_group = ListGroup.new(list_group_params)
    respond_to do |format|
      if @list_group.save
        flash[:success] = 'List group was successfully created.'  
        format.html { redirect_to admin_list_group_url(@list_group) }
        format.json { render :show, status: :created, location: @list_group }
      else
        format.html { render :new }
        format.json { render json: @list_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /list_group_/1
  # PATCH/PUT /list_group_/1.json
  def update
    respond_to do |format|
      if @list_group.update(list_group_params)
        flash[:success] =  'List group was successfully updated.'
        format.html { redirect_to admin_list_group_url(@list_group) }
        format.json { render :show, status: :ok, location: @list_group }
      else
        format.html { render :edit }
        format.json { render json: @list_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /list_group_/1
  # DELETE /list_group_/1.json
  def destroy
    @list_group.destroy
    respond_to do |format|
      flash[:success] = 'List group was successfully deleted.' 
      format.html { redirect_to admin_list_groups_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list_group
      @list_group = ListGroup.find_by(id: params[:id],site_id: @site.id)
      redirect_to admin_errors_url(error_template: '403') unless @list_group
    end

    def set_list_type
      @list_group = ListGroup.new
    end  

    # Never trust parameters from the scary internet, only allow the white list_group through.
    def list_group_params
      params.require(:list_group).permit(:name,:site_id,:css_classes)
    end
end
