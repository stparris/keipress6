class Admin::ImagePublishesController < AdminController
  before_action :set_image_publish, only: [:create]

  layout 'admins'


  def create
    respond_to do |format|
      @image_publish.publish
      @image_publish.save
      format.html { redirect_to admin_image_url(@image_publish.image) }
    end
  end

  private

    def set_image_publish
      @image_publish = ImagePublish.find(params[:image_publish][:parent_id])
    end

end
