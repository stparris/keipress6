class Admin::ArticlePostsController < AdminController
  before_action :set_article_post, only: [:show, :edit, :update, :destroy]
  before_action :set_new, only: [:new]

  layout 'admins'

  def sort
    params[:article_post].each_with_index do |id, index|
      item = ArticlePost.find(id)
      item.update_attribute(:position, index + 1) if item
    end
    render body: nil
  end

  # GET /article_posts
  # GET /article_posts.json
  def index
  end

  # GET /article_posts/1
  # GET /article_posts/1.json
  def show
  end

  # GET /article_posts/new
  def new

  end

  # GET /article_posts/1/edit
  def edit
  end


  # POST /article_posts
  # POST /article_posts.json
  def create
    @article_post = ArticlePost.new(article_post_params)
    @article = @article_post.article
    respond_to do |format|
      begin
        @article_post.save
        flash[:success] = 'Post was successfully created.'
        format.html { redirect_to admin_article_url(@article) }
        format.json { render :show, status: :created, location: @article_post }
      rescue Exception => e
        flash[:danger] = "Oops! Something went wrong: #{e.message}"
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /article_posts/1
  # PATCH/PUT /article_posts/1.json
  def update
    respond_to do |format|
      begin
        @article_post.update(article_post_params)
        flash[:success] = 'Post was successfully updated.'
        format.html { redirect_to admin_article_url(@article_post.article) }
      rescue Exception => e
        flash[:danger] = "Oops! Something went wrong: #{e.message}"
        format.html { render :edit }
      end
    end
  end

  # DELETE /article_posts/1
  # DELETE /article_posts/1.json
  def destroy
    respond_to do |format|
      begin
        if @article_post.destroy
          flash[:success] = 'Post was successfully removed.'
          format.html { redirect_to admin_article_url(@article) }
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
    def set_article_post
      @article_post = ArticlePost.find(params[:id])
      @article = @article_post.article
    end

    def set_new
      @article_post = ArticlePost.new
      @article_post.content_type = params[:content_type].present? ? params[:content_type] : nil
      @article = Article.find(params[:content_id])
      @article_post.article = @article
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_post_params
      params.require(:article_post).permit(
        :name,
        :css_classes,
        :content_id,
        :content_type,
        :image_id,
        :carousel_id,
        :image_group_id,
        :medium_id,
        :list_group_id,
        :link_text_id,
        :text_html_flag,
        :body,
        :admin_id,
        :include_admin_handle,
        :include_update_time,
        :include_caption,
        :include_copyright,
        :include_description,
        :position)
    end
end
