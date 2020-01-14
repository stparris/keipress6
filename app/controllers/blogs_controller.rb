class BlogsController < ApplicationController
  before_action :set_blog, only: [:show]

  # GET /blogs
  # GET /blogs.json
  def index
    @blogs = Blog.joins(:page).where(site_id: @site.id)
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
    respond_to do |format|
      begin
        @page && @blog
      rescue
        format.html { redirect_to errors_url(404) }
      end
    end
  end
 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.where(nice_url: params[:nice_url], site_id: @site.id) if params[:nice_url].present?
      @blog = Blog.find(params[:id]) if params[:id].present?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
       params.require(:blog).permit(:nice_url)
    end
end
