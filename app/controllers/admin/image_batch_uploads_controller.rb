class Admin::ImageBatchUploadsController < AdminController
  before_action :set_image_batch

  def create
    @message = ""
    @image_batch_upload = ImageBatchUpload.new(image_batch_upload_params)
    files = params[:image_batch_upload][:upload_images]
    seq = @image_batch.naming_method == 'use_filename' ? nil : @image_batch.naming_sequence
    files.each do |upload_file|
      begin
        image = Image.where(
          name: seq ? "#{@image_batch.naming_prefix} #{seq}" : upload_file.original_filename.sub(/\.\S+$/,''),
          caption: @image_batch.caption,
          copyright_year: @image_batch.copyright_year,
          copyright_by: @image_batch.copyright_by,
          description: @image_batch.description,
          site_id: @site.id).first_or_create
        image_preview = ImagePreview.where(
          image_id: image.id,
          source_file: upload_file.original_filename,
          content_type: upload_file.content_type,
          preview_type: 'original').first_or_create
        ImageBatchImage.where(image_id: image.id,image_batch_id: @image_batch.id).first_or_create
        file_name = "#{Rails.root}/public/image_previews/original_#{image_preview.image_id}.#{image_preview.file_extention}"
        File.open(file_name, 'wb') do |file|
          file.write(upload_file.read)
        end
        image_preview.save!
        if @image_batch.quality > 0
          image_optimize = ImageOptimization.where(
            image_id: image.id,
            parent_id: image_preview.id,
            source_file: upload_file.original_filename,
            content_type: upload_file.content_type,
            preview_type: 'optimize').first_or_create
          image_optimize.size = image_preview.size
          image_optimize.max_width = image_preview.get_max_width
          image_optimize.quality = @image_batch.quality
          optimize_file = "#{Rails.root}/public/image_previews/optimize_#{image.id}.#{image_preview.file_extention}"
          FileUtils.cp file_name, optimize_file
          image_optimize.optimize
          image_optimize.save
        end
        if image_optimize && @image_batch.publish
          image_publish = ImagePublish.find(image_optimize.id)
          image_publish.publish
        end
        if @image_batch.image_group
          ImageGroupItem.where(image_id: image.id, image_group_id: @image_batch.image_group_id).first_or_create
        end
        if @image_batch.category
          CategoriesImage.where(image_id: image.id, category_id: @image_batch.category_id).first_or_create
        end
      rescue ImagePreview::ImageTooBigError, ImagePreview::ImageInvalidTypeError => e
        @message += "Error: #{e.message} "
        FileUtils.rm file_name if File.exists?(file_name)
      end
    end
    respond_to do |format|
      format.html {redirect_to admin_image_batch_url(@image_batch)}
    end
  end

  private

    def set_image_batch
      @image_batch = ImageBatch.find(params[:image_batch_upload][:image_batch_id])
    end

    def image_batch_upload_params
      params.require(:image_batch_upload).permit(:image_batch_id, :upload_images)
    end

end
