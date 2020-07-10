class Admin::ArticlesController < AdminController
  before_action :set_article, only: [:show, :edit, :update, :destroy, :category]
  before_action :set_category, only: [:category]

  layout 'admins'

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.where(site_id: @site.id).order('name asc')
  end

  # GET /articles/1
  # GET /articles/1.json
  def show

  end

  # GET /articles/new
  def new
    @article = Article.new
    @article.site = @site
  end

  # GET /articles/1/edit
  def edit
  end

  def category
    respond_to do |format|
      format.js do
        if @category
          if @article.categories.include?(@category)
            @article.categories.delete(@category)
          else
            @article.categories << @category
          end
        end
      end
    end
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    respond_to do |format|
      begin
        if @article.save
          flash[:success] = 'Article was successfully created.'
          format.html { redirect_to admin_article_url(@article) }
          format.json { render :show, status: :created, location: @article }
        else
          format.html { render :new }
          format.json { render json: @article.errors, status: :unprocessable_entity }
        end
      rescue Exception => e
        flash[:danger] = "Oops! Something went wrong: #{e.message}"
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      begin
        if @article.update(article_params)
          flash[:success] = 'Article was successfully updated.'
          format.html { redirect_to admin_article_url(@article) }
          format.json { render :show, status: :ok, location: @article }
        else
          format.html { render :edit }
          format.json { render json: @article.errors, status: :unprocessable_entity }
        end
      rescue Exception => e
        flash[:danger] = "Oops! Something went wrong: #{e.message}"
        format.html { render :new }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    respond_to do |format|
      begin
        if @article.destroy
                    flash[:success] = 'Article was successfully removed.'
          format.html { redirect_to admin_articles_url }
          format.json { head :no_content }
        end
      rescue Exception => e
        flash[:danger] = "Oops! Something went wrong: #{e.message}"
        format.html { render :new }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    def set_category
      @category = params[:category_id].present? ? Category.find(params[:category_id]) : nil
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(
        :site_id,
        :name,
        :content_url,
        :page_id,
        :css_classes,
        :published)
    end
end
