class Admin::ImageOptimizationsController < AdminController
  before_action :set_image_optimization, only: [:edit, :update]

  require "image_processing/vips"

  layout 'admins'

  # GET /image_optimizations/1/edit
  def edit
    width_height = ActiveStorage::Analyzer::ImageAnalyzer.new(@image_optimization.image.blob).metadata.with_indifferent_access
    @image_optimization.max_width = width_height['width']
    if !@image_optimization.image.attached? || @image_optimization.quality
      respond_to do |format|
        format.html { redirect_to admin_image_url(@image_optimization) }
      end
    end
  end

  # PATCH/PUT /image_optimizations/1
  # PATCH/PUT /image_optimizations/1.json
  def update
    respond_to do |format|
      begin
        if @image_optimization.update(image_optimization_params)
          flash[:success] = 'Image optimized.'    
          filename = @image_optimization.image.filename
          content_type = @image_optimization.image.content_type
          tempfile = "tempfile_#{rand.to_s}.jpg"
          optimizedfile = "optimized_#{rand.to_s}.jpg"    
          binary = @image_optimization.image.download
          File.open("#{Rails.root}/tmp/#{tempfile}", "wb") do |f|
            f.write(binary)
          end
          ImageProcessing::Vips
            .source("#{Rails.root}/tmp/#{tempfile}") 
            .resize_to_limit(@image_optimization.max_width.to_i,@image_optimization.max_width.to_i)
            .saver(strip: true)
            .saver(quality: @image_optimization.quality.to_i)
            .call(destination: "#{Rails.root}/tmp/#{optimizedfile}")
          @image_optimization.image.purge
          @image_optimization.image.attach(io: File.open("#{Rails.root}/tmp/#{optimizedfile}"), filename: "#{filename}", content_type: "#{content_type}") 
          @image_optimization.save
          FileUtils.rm("#{Rails.root}/tmp/#{tempfile}")
          FileUtils.rm("#{Rails.root}/tmp/#{optimizedfile}")
          format.html { redirect_to admin_image_url(@image_optimization) }
        else
          flash[:danger] = "Oops! Something went wrong."
          format.html { render :edit }
          format.json { render json: @carousel.errors, status: :unprocessable_entity }
        end
      rescue Exception => e 
        flash[:danger] = "Oops! Something went wrong: #{e.message}"
        format.html { render :edit }
      end
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image_optimization
      @image_optimization = ImageOptimization.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_optimization_params
      params.require(:image_optimization).permit(:max_width,:quality)
    end
end
