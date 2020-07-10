class Admin::ContentGroupsController < AdminController
  before_action :set_content_group, only: [:show, :edit, :update, :destroy]

  layout 'admins'

  # GET /content_groups
  # GET /content_groups.json
  def index
    @content_group = nil
    @content_groups = ContentGroup.where(site_id: @site.id).order('name asc')
  end

  # GET /content_groups/1
  # GET /content_groups/1.json
  def show
  end

  # GET /content_groups/new
  def new
    @content_group = ContentGroup.new
    @content_group.site = @site
  end

  # GET /content_groups/1/edit
  def edit
  end

  # POST /content_groups
  # POST /content_groups.json
  def create
    @content_group = ContentGroup.new(content_group_params)
    respond_to do |format|
      begin
        if @content_group.save
          flash[:success] = 'Content group was successfully created.'
          format.html { redirect_to admin_content_group_url(@content_group) }
          format.json { render :show, status: :created, location: @content_group }
        else
          format.html { render :new }
          format.json { render json: @content_group.errors, status: :unprocessable_entity }
        end
      rescue Exception => e
        flash[:danger] = "Oops! Something went wrong: #{e.message}"
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /content_groups/1
  # PATCH/PUT /content_groups/1.json
  def update
    respond_to do |format|
      begin
        if @content_group.update(content_group_params)
          flash[:success] = 'Content Group was successfully updated.'
          format.html { redirect_to admin_content_group_url(@content_group) }
          format.json { render :show, status: :ok, location: @content_group }
        else
          format.html { render :edit }
          format.json { render json: @content_group.errors, status: :unprocessable_entity }
        end
      rescue Exception => e
        flash[:danger] = "Oops! Something went wrong: #{e.message}"
        format.html { render :new }
      end
    end
  end

  # DELETE /content_groups/1
  # DELETE /content_groups/1.json
  def destroy
    respond_to do |format|
      begin
        if @content_group.destroy
          flash[:success] = 'Content group was successfully removed.'
          format.html { redirect_to admin_content_groups_url }
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
    def set_content_group
      @content_group = ContentGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def content_group_params
      params.require(:content_group).permit(:site_id,:name,:css_classes)
    end
end
