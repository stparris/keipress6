class Admin::ContentGroupClonesController < AdminController

  before_action :set_content_group, only: [:new, :create]

  layout 'admins'

  # GET /ContentGroups/new
  def new
    @content_group_clone = @content_group.dup
    @content_group_clone.name = "Clone of #{@content_group.name}"
  end

  # POST /ContentGroups
  # POST /ContentGroups.json
  def create
    @content_group_clone = ContentGroup.new(content_group_clone_params)
    respond_to do |format|
      if @content_group_clone.save
          @content_group.content_group_items.each do |item|
          clone_item = item.dup
          clone_item.content_id = @content_group_clone.id
          clone_item.save
        end
        flash[:success] = 'Content group was successfully cloned.'
        format.html { redirect_to admin_content_group_url(@content_group_clone) }
        format.json { render :show, status: :created, location: @content_group_clone }
      else
        format.html { render :new }
        format.json { render json: @content_group_clone.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_content_group
      @content_group = ContentGroup.find(params[:content_group_id])
      @content_group_clone = @content_group.dup
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def content_group_clone_params
      params.require(:content_group_clone).permit(:site_id,:name,:css_classes)
    end	

end
