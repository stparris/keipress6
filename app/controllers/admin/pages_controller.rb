class Admin::PagesController < AdminController
  before_action :set_page, except: [:create, :new, :index]

  layout 'admins'

  # GET /pages
  # GET /pages.json
  def index
    @pages = Page.where(site_id: @site.id).order('name asc')
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
    @containers_pages = @page.containers_pages 
  end

  # GET /pages/new
  def new
    @page = Page.new
    @page.site = @site
  end

  # GET /pages/1/edit
  def edit
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(page_params)
    respond_to do |format|
      begin
        if @page.save
          flash[:success] = 'Page was successfully created.'
          format.html { redirect_to admin_page_url(@page) }
          format.json { render :show, status: :created, location: @page }
        else
          format.html { render :new }
          format.json { render json: @page.errors, status: :unprocessable_entity }
        end
      rescue Exception => e 
        flash[:danger] = "Oops! Something went wrong: #{e.message}"
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /pages/1
  # PATCH/PUT /pages/1.json
  def update
    respond_to do |format|
      begin
        if @page.update(page_params)
          flash[:success] = 'Page was successfully updated.'
          format.html { redirect_to admin_page_url(@page) }
          format.json { render :show, status: :ok, location: @page }
        else
          format.html { render :edit }
          format.json { render json: @page.errors, status: :unprocessable_entity }
        end
      rescue Exception => e 
        flash[:danger] = "Oops! Something went wrong: #{e.message}"
        format.html { render :new }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    respond_to do |format|
      begin
        if @page.destroy
          flash[:success] = 'Page was successfully removed.'
          format.html { redirect_to admin_pages_url }
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
    def set_page
      @page = Page.find_by(id: params[:id],site_id: @site.id)
      redirect_to admin_errors_url(error_template: '403') unless @page
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_params
      params.require(:page).permit(:site_id,:name,:nice_url,:description,:theme_id,:assignment)
    end
end
