class Admin::ImageGroupsController < AdminController
  before_action :set_image_group, only: [:show, :edit, :update, :destroy]

  layout 'admins'

  # GET /image_groups
  # GET /image_groups.json
  def index
    @image_groups = ImageGroup.all
  end

  # GET /image_groups/1
  # GET /image_groups/1.json
  def show
  end

  # GET /image_groups/new
  def new
    @image_group = ImageGroup.new(site_id: @site.id)
    @image_group.site = @site
  end

  # GET /image_groups/1/edit
  def edit
  end

  # POST /image_groups
  # POST /image_groups.json
  def create
    @image_group = ImageGroup.new(image_group_params)
    respond_to do |format|
      begin
        if @image_group.save
          flash[:success] = 'Image group was successfully created.'
          format.html { redirect_to admin_image_group_url(@image_group) }
          format.json { render :show, status: :created, location: @image_group }
        else
          format.html { render :new }
          format.json { render json: @image_group.errors, status: :unprocessable_entity }
        end
      rescue Exception => e
        flash[:danger] = "Oops! Something went wrong: #{e.message}"
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /image_groups/1
  # PATCH/PUT /image_groups/1.json
  def update
    respond_to do |format|
      begin
        if @image_group.update(image_group_params)
          flash[:success] = 'Image group was successfully updated.'
          format.html { redirect_to admin_image_group_url(@image_group) }
          format.json { render :show, status: :ok, location: @image_group }
        else
          format.html { render :edit }
          format.json { render json: @image_group.errors, status: :unprocessable_entity }
        end
      rescue Exception => e
        flash[:danger] = "Oops! Something went wrong: #{e.message}"
        format.html { render :new }
      end
    end
  end

  # DELETE /image_groups/1
  # DELETE /image_groups/1.json
  def destroy
    respond_to do |format|
      begin
        if @image_group.destroy
          flash[:success] = 'Image group was successfully removed.'
          format.html { redirect_to admin_image_groups_url }
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
    def set_image_group
      @image_group = ImageGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_group_params
      params.require(:image_group).permit(
          :name,
          :description,
          :css_classes,
          :image_group_type,
          :site_id,
          :image_id)
    end
end
