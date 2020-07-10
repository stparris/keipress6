class Admin::ContentAdminsController < AdminController
  before_action :set_content_admin, except: [:create]

  layout 'admins'

  def sort
    params[:content_admins].each_with_index do |id, index|
      item = ContentAdmin.find(id)
      item.update_attribute(:position, index + 1) if item
    end
    render body: nil
  end

  # POST /authors
  # POST /authors.json
  def create
    content_admin = ContentAdmin.new(content_admin_params)
    content_admin.save
    @content = content_admin.content
    respond_to do |format|
      format.js
    end
  end

  # DELETE /authors/1
  # DELETE /authors/1.json
  def destroy
    @content = @content_admin.content
    @content_admin.destroy
    respond_to do |format|
      format.js
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def set_content_admin
      @content_admin = ContentAdmin.find(params[:id])
    end

    def content_admin_params
      params.require(:content_admin).permit(:content_id,:admin_id)
    end
end
