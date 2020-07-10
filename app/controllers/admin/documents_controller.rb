class Admin::DocumentsController < AdminController
  before_action :set_document, only: [:show]

  layout 'admins'

  # GET /blogs
  # GET /blogs.json
  def index
    @blogs = Blog.where(site_id: @site.id).order('name asc')
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      url = params[:document_url] ? params[:document_url] : 'kei-press-documentation'
      @document = Article.find_by(content_url: url)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(:document_url)
    end
end
