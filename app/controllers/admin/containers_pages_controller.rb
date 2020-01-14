class Admin::ContainersPagesController < AdminController
  before_action :set_containers_page, only: [:show, :edit, :update, :destroy]
  before_action :set_new, only: [:create]

  layout 'admins'

  def sort
    params[:containers_page].each_with_index do |id, index|
      item = ContainersPage.find(id)
      item.update_attribute(:position, index + 1) if item
    end
    render body: nil
  end

  # GET /containers_pages
  # GET /containers_pages.json
  def index
    @containers_pages = @page.containers_pages
  end

  # GET /containers_pages/1
  # GET /containers_pages/1.json
  def show
  end

  # POST /containers_pages
  # POST /containers_pages.json
  def create
    @containers_page = ContainersPage.new(containers_page_params)
    respond_to do |format|
      if @containers_page.save
        @containers_pages = @page.containers_pages
        format.js
        format.html do 
          flash[:success] = 'Container was successfully added to page.'
          redirect_to @containers_page
        end
        format.json { render :show, status: :created, location: @containers_page }
      else
        format.js { head :ok }
        format.html { render :new }
        format.json { render json: @containers_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /containers_pages/1
  # DELETE /containers_pages/1.json
  def destroy
    @page = @containers_page.page
    @containers_page.destroy
    @containers_pages = @page.containers_pages
    respond_to do |format|
      format.js
      format.html do 
        flash[:success] = 'Container was successfully removed from page.' 
        redirect_to containers_pages_url 
      end
      format.json { head :no_content }
    end
  end

  private
    def set_new
      @page = Page.find_by(id: params[:containers_page][:page_id],site_id: @site.id)
      redirect_to admin_errors_url(error_template: '403') unless @page
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_containers_page
      @containers_page = ContainersPage.find(params[:id])
      redirect_to admin_errors_url(error_template: '403') unless @containers_page.page.site == @site
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def containers_page_params
      params.require(:containers_page).permit(:container_id,:page_id)
    end	
end
