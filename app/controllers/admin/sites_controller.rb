class Admin::SitesController < AdminController
  before_action :set_site, only: [:show, :edit, :update, :destroy]
  before_action :set_new, only: [:new]

  layout 'admins'

  # GET /sites
  # GET /sites.json
  def index
    @sites = @admin.role == 1 ? Site.all : @admin.sites
      @site = nil
      session[:site_id] = nil
    end

  # GET /sites/1
  # GET /sites/1.json
  def show
    unless @site
      @error = Error.new(error_template: '403')
      render 'admin/errors/show'
    end
  end

  # GET /sites/new
  def new

  end

  # GET /sites/1/edit
  def edit
  end

  # POST /sites
  # POST /sites.json
  def create
    @site = Site.new(site_params)
    respond_to do |format|
      begin
        if @site.save
          flash[:success] = 'Site was successfully created.'
          format.html { redirect_to admin_site_url(@site) }
          format.json { render :show, status: :created, location: @site }
        else
          format.html { render :new }
          format.json { render json: @site.errors, status: :unprocessable_entity }
        end
      rescue Exception => e
        flash[:danger] = "Oops! Something went wrong: #{e.message}"
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /sites/1
  # PATCH/PUT /sites/1.json
  def update
    respond_to do |format|
      begin
        if @site.update(site_params)
          flash[:success] = 'Site was successfully updated.'
          format.html { redirect_to admin_site_url(@site) }
          format.json { render :show, status: :ok, location: @site }
        else
          format.html { render :edit }
          format.json { render json: @site.errors, status: :unprocessable_entity }
        end
      rescue Exception => e
        flash[:danger] = "Oops! Something went wrong: #{e.message}"
        format.html { render :new }
      end
    end
  end

  # DELETE /sites/1
  # DELETE /sites/1.json
  def destroy
    respond_to do |format|
      begin
        if @site.destroy
          @page = nil
          flash[:success] = 'Site was successfully removed.'
          format.html { redirect_to admin_sites_url }
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
    def set_site
      if @admin.role == 1
        @site = Site.find(params[:id])
      else
        @site = @admin.sites.find_by_id(params[:id])
      end
      session[:site_id] = @site.id if @site
    end

    def set_new
      @site = Site.new
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def site_params
      params.require(:site).permit(:name,:description,:keywords,:favicon,:analytics,:time_zone)
    end
end
