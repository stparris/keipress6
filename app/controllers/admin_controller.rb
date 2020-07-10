class AdminController < ApplicationController
  before_action :require_admin

  protected

    def set_admin_site
      if params[:site_id].present?
        @site = Site.find_by_id(params[:site_id])
      elsif session[:site_id].present?
        @site = Site.find_by_id(session[:site_id])
      else
        # @site = Site.joins(:domains).where("domains.name = ?", request.domain).first
        @site = @admin.sites.first
      end
    end

    def require_admin
      unless request.fullpath == '/admin/login' || request.fullpath == '/admin/admin_sessions'
       	@admin = session[:admin_token] ? Admin.find_by_admin_token(session[:admin_token]) : nil
        if @admin
          if @admin.sites.any? || @admin.role == 1
            set_admin_site
logger.info "\n============\n#{@admin.inspect} #{@site.inspect}\n\n"
            unless (@site && (@admin.sites.include?(@site)) || @admin.role == 1)
              redirect_to admin_errors_url(error_template: '403')
            end
          else
            redirect_to admin_errors_url(error_template: "403", message: "Your account doesn't have any sites assigned to it.")
          end
        else
          session[:admin_token] = nil
          redirect_to admin_login_path
        end
      end
      show_debug('admin_controller')
    end

end

