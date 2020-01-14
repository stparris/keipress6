class Admin::CategoriesController < AdminController
  before_action :set_category, only: [:show, :edit, :update, :destroy, :image, :article]
  before_action :set_image, only: [:image]
  before_action :set_article, only: [:article]
  before_action :set_medium, only: [:medium]

  layout 'admins'

  # GET /Categorys
  # GET /Categorys.json
  def index
    @categories = Category.where(site_id: @site.id).order('name asc')
  end

  # GET /Categorys/1
  # GET /Categorys/1.json
  def show

  end

  # GET /Categorys/new
  def new
    @category = Category.new
  end

  # GET /Categorys/1/edit
  def edit
  end

  def image
    respond_to do |format|
      format.js do
        if @image
          if @category.images.include?(@image)
            @category.images.delete(@image)
          else
            @category.images << @image
          end
        end
      end
    end
  end

  def article
    respond_to do |format|
      format.js do
        if @article
          if @category.contents.include?(@article)
            @category.contents.delete(@article)
          else
            @category.contents << @article
          end
        end
      end
    end
  end

  def medium
    respond_to do |format|
      format.js do
        if @medium
          if @category.media.include?(@medium)
            @category.media.delete(@medium)
          else
            @category.media << @medium
          end
        end
      end
    end
  end



  # POST /Categorys
  # POST /Categorys.json
  def create
    @category = Category.new(category_params)
    respond_to do |format|
      if @category.save
        flash[:success] = 'Category was successfully created.'
        format.html do 
          redirect_to admin_category_url(@category)
        end      
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /Categorys/1
  # PATCH/PUT /Categorys/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        flash[:success] = 'Category was successfully updated.'
        format.html { redirect_to admin_category_url(@category) }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /Categorys/1
  # DELETE /Categorys/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      flash[:success] = 'Category was successfully deleted.'
      format.html { redirect_to admin_categories_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find_by(id: params[:id],site_id: @site.id)
      redirect_to admin_errors_url(error_template: '403') unless @category 
    end

    def set_article
      @article = params[:article_id].present? ? Article.find(params[:article_id]) : nil 
    end

    def set_medium
      @medium = params[:medium_id].present? ? Article.find(params[:medium_id]) : nil 
    end

    def set_image
      @image = params[:image_id].present? ? Image.find(params[:image_id]) : nil 
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name,:nice_url,:site_id)
    end	
end
