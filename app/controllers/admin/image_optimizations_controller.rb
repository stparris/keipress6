class Admin::ImageOptimizationsController < AdminController
  before_action :set_new, only: [:new]
  before_action :set_image_optimization, only: [:edit, :update]

  layout 'admins'

  def new
  end

  # GET /image_optimizations/1/edit
  def edit
  end

  # PATCH/PUT /image_optimizations/1
  # PATCH/PUT /image_optimizations/1.json
  def update
    respond_to do |format|
       begin
        flash[:success] = 'Image optimized.'
        @image_optimization.update(image_optimization_params)
        @image_optimization.optimize
        @image_optimization.save
        format.html { redirect_to admin_image_preview_url(@image_optimization.image) }
      rescue Exception => e
        flash[:danger] = "Oops! Something went wrong: #{e.message}"
        format.html { render :edit }
      end
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_new
      parent = ImagePreview.find(params[:parent_id])
      file_name = "#{Rails.root}/public/image_previews/#{parent.preview_type}_#{parent.image_id}.#{parent.file_extention}"
      optimize_file = "#{Rails.root}/public/image_previews/optimize_#{parent.image_id}.#{parent.file_extention}"
      FileUtils.cp file_name, optimize_file
      @image_optimization = ImageOptimization.where(
        image_id: parent.image_id,
        preview_type: 'optimize').first_or_create!
      @image_optimization.parent_id = parent.id
      @image_optimization.source_file = parent.source_file
      @image_optimization.content_type = parent.content_type
      @image_optimization.size = parent.size
      @image_optimization.max_width = parent.get_max_width
      @image_optimization.save
      @image_url = "/image_previews/optimize_#{parent.image_id}.#{parent.file_extention}"
      @image_preview = ImagePreview.find_by(image_id: parent.image_id, preview_type: 'original')
      @image_crop = ImagePreview.find_by(image_id: parent.image_id, preview_type: 'crop')
    end

    def set_image_optimization
      @image_optimization = ImageOptimization.find(params[:id])
      @image_url = "/image_previews/optimize_#{@image_optimization.image_id}.#{@image_optimization.file_extention}"
      @image_optimization.max_width = @image_optimization.get_max_width
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_optimization_params
      params.require(:image_optimization).permit(
        :max_width,
        :parent_id,
        :source_file,
        :content_type,
        :size,
        :preview_type,
        :quality)
    end
end
