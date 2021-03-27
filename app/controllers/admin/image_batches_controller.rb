class Admin::ImageBatchesController < AdminController
  before_action :set_assets, only: [:create, :update]
  before_action :set_image_batch, except: [:new, :index, :create]

  layout 'admins'

  def index
    @image_batches = ImageBatch.where(site_id: @site.id).order('name asc')
  end

  def new
    @image_batch = ImageBatch.new
  end

  def show

  end

  def upload
    logger.info "\n========image_upload==========\n#{@image_batch.image_upload}"
    # @image_batch.image_upload.each do |file|
    #   logger.info "\n=========================\n#{file.original_filename}\n======================"
    #   logger.info "\n=========================\n#{file.content_type}\n======================"
    #   logger.info "\n=========================\n#{@image_batch.image_upload.inspect}\n======================"
    # end
  end

  def update
    respond_to do |format|
      if @image_batch.update(image_batch_params)
        flash[:success] = 'Image batch was successfully updated.'
        if @image_group || @category
          @image_batch.image_group = @image_group if @image_group
          @image_batch.category = @category if @category
          @image_batch.save
        end
        format.html { redirect_to admin_image_batch_url(@image_batch) }
        format.json { render :show, status: :created, location: @image }
      else
        format.html { render :new }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @image_batch = ImageBatch.new(image_batch_params)
    @image_batch.image_group = @image_group if @image_group
    @image_batch.category = @category if @category
    respond_to do |format|
      if @image_batch.save
        flash[:success] = 'Image batch was successfully created.'
        format.html { redirect_to admin_image_batch_url(@image_batch) }
        format.json { render :show, status: :created, location: @image }
      else
        format.html { render :new }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      begin
        # image batch options? remove all images?
        if @image_batch.images.any? && params[:delete_all].present?
          @image_batch.images.each do |image|
            FileUtils.rm Dir.glob("#{Rails.root}/public/image_previews/*_#{image.id}.*")
            image.destroy
          end
        end
        if @image_batch.destroy
          flash[:success] = 'Image batch was successfully removed.'
          format.html { redirect_to admin_image_batches_url }
          format.json { head :no_content }
        end
      rescue Exception => e
        flash[:danger] = "Oops! Something went wrong: #{e.message}"
        format.html { render :new }
      end
    end
  end

  private

    def set_assets
      if params[:image_batch][:image_group_name] =~ /\S+/
        @image_group = ImageGroup.where(name: params[:image_batch][:image_group_name], site_id: @site.id).first_or_create
      end
      if params[:image_batch][:category_name] =~ /\S+/
        @category = Category.where(name: params[:image_batch][:category_name], site_id: @site.id).first_or_create
      end
    end

    def set_image_batch
      @image_batch = ImageBatch.find(params[:id])
    end

    def image_batch_params
      params.require(:image_batch).permit(
                      :site_id,
                      :image_group_name,
                      :category_name,
                      :image_group_id,
                      :category_id,
                      :name,
                      :description,
                      :caption,
                      :copyright_by,
                      :copyright_year,
                      :naming_method,
                      :naming_prefix,
                      :naming_sequence,
                      :publish,
                      :quality,
                      :upload_images)
    end

end
