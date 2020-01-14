class ArticlesController < ApplicationController
  before_action :set_article, only: [:show]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    respond_to do |format|
      begin
        @page && @article
      rescue
        format.html { redirect_to errors_url(404) }
      end
    end
  end
 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.where(nice_url: params[:nice_url], site_id: @site.id) if params[:nice_url].present?
      @article = Article.find(params[:id]) if params[:id].present?
      @page = @article.page
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.fetch(:article, {})
    end
end
