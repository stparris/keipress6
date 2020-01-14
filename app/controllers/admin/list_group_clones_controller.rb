class Admin::ListGroupClonesController < AdminController
  before_action :set_list_group, only: [:new,:create]

  layout 'admins'

  # GET /list_group_/new
  def new
  end

  # POST /list_group_
  # POST /list_group_.json
  def create
    @list_group_clone = ListGroupClone.new(list_group_clone_params)
    respond_to do |format|
      if @list_group_clone.save
        @list_group.list_group_items.each do |item|
          clone_item = item.dup
          clone_item.list_group_id = @list_group_clone.id
          clone_item.save
        end
        flash[:success] = 'List group clone was successfully created.'  
        format.html { redirect_to admin_list_group_url(@list_group_clone) }
        format.json { render :show, status: :created, location: @list_group_clone }
      else
        format.html { render :new }
        format.json { render json: @list_group_clone.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list_group
      @list_group = ListGroup.find(params[:list_group_id])
      @list_group_clone = @list_group
    end

    # Never trust parameters from the scary internet, only allow the white list_group through.
    def list_group_clone_params
      params.require(:list_group_clone).permit(:name,:site_id,:css_classes)
    end
end
