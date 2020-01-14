class Admin::BlogPostsController < AdminController
  before_action :set_blog_post, only: [:show, :edit, :update, :destroy]
  before_action :set_new, only: [:new]

  layout 'admins'

  def sort
    params[:blog_post].each_with_index do |id, index|
      item = BlogPost.find(id)
      item.update_attribute(:position, index + 1) if item
    end
    render body: nil
  end

  # GET /blog_posts
  # GET /blog_posts.json
  def index
  end

  # GET /blog_posts/1
  # GET /blog_posts/1.json
  def show
  end

  # GET /blog_posts/new
  def new

  end

  # GET /blog_posts/1/edit
  def edit
  end

  # POST /blog_posts
  # POST /blog_posts.json
  def create
    @content_item = BlogPost.new(blog_post_params)
    respond_to do |format|
      begin
        if @content_item.save
          flash[:success] = 'Post was successfully created.'
          format.html { redirect_to admin_blog_post_url(@content_item) }
          format.json { render :show, status: :created, location: @content_item }
        else
          format.html { render :new }
          format.json { render json: @content_item.errors, status: :unprocessable_entity }
        end
      rescue Exception => e 
        flash[:danger] = "Oops! Something went wrong: #{e.message}"
        format.html { render :new }
      end   
    end
  end

  # PATCH/PUT /blog_posts/1
  # PATCH/PUT /blog_posts/1.json
  def update
    respond_to do |format|
      begin
        if @content_item.update(blog_post_params)
          flash[:success] = 'Post was successfully updated.'
          format.html { redirect_to admin_blog_post_url(@content_item) }
          format.json { render :show, status: :ok, location: @content_item }
        else
          format.html { render :edit }
          format.json { render json: @content_item.errors, status: :unprocessable_entity }
        end
      rescue Exception => e 
        flash[:danger] = "Oops! Something went wrong: #{e.message}"
        format.html { render :new }
      end   
    end
  end

  # DELETE /blog_posts/1
  # DELETE /blog_posts/1.json
  def destroy
    respond_to do |format|
      begin  
        if @content_item.destroy
          flash[:success] = 'Post was successfully removed.'
          format.html { redirect_to admin_blog_url(@blog) }
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
    def set_blog_post
      @content_item = BlogPost.find(params[:id])
      @blog = @content_item.blog
    end

    def set_new
      @content_item = BlogPost.new
      @content_item.content_type = params[:content_type].present? ? params[:content_type] : nil 
      @content_item.blog = @blog || params[:content_id].present? ? Blog.find(params[:content_id]) :nil
      @content_item.admin = @admin
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_post_params
      params.require(:blog_post).permit(
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
