class Admin::AdminsSitesController < AdminController
  before_action :set_admins_site, only: [:create, :destroy]

  layout 'admins'

  # GET /admin_sites
  # GET /admin_sites.json
  def index
  end


  # POST /admin_sites
  # POST /admin_sites.json
  def create
    respond_to do |format|
 #     begin
        if @site_obj && @admin_obj
          AdminsSite.where(admin_id: @admin_obj.id,site_id: @site_obj.id).first_or_create
          format.js
        end
    #  rescue Exception => e 
    #    logger.info "Oops! Something went wrong: #{e.message}"
    #  end
    end
  end

  # DELETE /admin_sites/1
  # DELETE /admin_sites/1.json
  def destroy
    respond_to do |format|
     # begin
        if @site_obj && @admin_obj
          AdminsSite.where(admin_id: @admin_obj.id,site_id: @site_obj.id).delete_all
          format.js 
        end
      #rescue Exception => e 
      #  logger.info "Oops! Something went wrong: #{e.message}"
      #end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admins_site
      if @admin.role == 1
        # admins_site"=>{"site_obj_id"=>"4", "admin_obj_id"=>"4"}
        if params[:admins_site].present?
          @site_obj = params[:admins_site][:admin_obj_id].present? ? Site.find(params[:admins_site][:site_obj_id]) : nil
          @admin_obj = params[:admins_site][:admin_obj_id].present? ? Admin.find(params[:admins_site][:admin_obj_id]) : nil
        else
          @site_obj = params[:admin_obj_id].present? ? Site.find(params[:site_obj_id]) : nil
          @admin_obj = params[:admin_obj_id].present? ? Admin.find(params[:admin_obj_id]) : nil
        end
  logger.info "========================================\n#{@site_obj.inspect}"
  logger.info "========================================\n#{@admin_obj.inspect}"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admins_site_params
      params.require(:admins_site).permit(:site_obj_id,:admin_obj_id)
    end
end
