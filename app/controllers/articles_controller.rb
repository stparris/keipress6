class ArticlesController < ProductionController
  before_action :set_article, only: [:show]
  before_action :set_page

  layout 'application'

  # GET /articles
  # GET /articles.json
  def index
    if params[:more]
      more = params[:more]
      offset = more.to_i -1 * 20
      @more_next =  more.to_i + 1
      @articles = Article.find_by(site_id: @site.id, published: true).order('updated_at: desc').limit(20).offset(offset)
    else
      @articles = Article.find_by(site_id: @site.id, published: true).order('updated_at: desc').limit(20)
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      if params[:content_url].present? && params[:content_url] =~ /kei-press-documentation/
        @article = Article.find_by(content_url: params[:content_url].split(/\?|\#/)[0], site_id: 2)
        @section = params[:section].present? ? params[:section] : nil
      elsif params[:content_url].present? && params[:content_url] =~ /kei-press-how-tos/
        @article = Article.find_by(content_url: params[:content_url].split(/\?/)[0], site_id: 2)
      elsif params[:id].present?
        @article = Article.find(params[:id])
      elsif params[:content_url].present?
        @article = Article.find_by(content_url: params[:content_url].split(/\?/)[0], site_id: @site.id)
      elsif params[:id].present?
        @article = Article.find(params[:id])
      else
        @article = nil
      end
    end

    def set_page
      @page = @article && @article.page ? @article.page : Page.find_by(assignment: 'article')
    end

end
