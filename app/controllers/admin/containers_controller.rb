class Admin::ContainersController < AdminController
  before_action :set_container, except: [:create, :new, :index]
  before_action :set_new, only: [:new]

  layout 'admins'

  # GET /Containers
  # GET /Containers.json
  def index
    @containers = Container.where(site_id: @site.id).order('name asc')
  end

  # GET /Containers/1
  # GET /Containers/1.json
  def show
    @navigation = nil
    @container_row = nil
    unless @container.container_type == 'navigation'
      @container_rows = @container.container_rows
    end
  end

  # GET /Containers/new
  def new

  end

  # GET /Containers/1/edit
  def edit
  end

  # POST /Containers
  # POST /Containers.json
  def create
    @container = Container.new(container_params)
    respond_to do |format|
      if @container.save
        flash[:success] = 'Container was successfully created.'
        format.html do
          if @page
            ContainersPage.create(container_id: @container.id,page_id: @page.id)
            redirect_to admin_page_url(@page)
          else
            redirect_to admin_container_url(@container)
          end
        end
        format.json { render :show, status: :created, location: @container }
      else
        format.html { render :new }
        format.json { render json: @container.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /Containers/1
  # PATCH/PUT /Containers/1.json
  def update
    respond_to do |format|
      if @container.update(container_params)
        flash[:success] = 'Container was successfully updated.'
        if @page
          format.html { redirect_to admin_page_url(@page) }
        else
          format.html { redirect_to admin_container_url(@container) }
        end
        format.json { render :show, status: :ok, location: @container }
      else
        format.html { render :edit }
        format.json { render json: @container.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /Containers/1
  # DELETE /Containers/1.json
  def destroy
    @container.destroy
    respond_to do |format|
      flash[:success] = 'Container was successfully deleted.'
      format.html { redirect_to admin_containers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_container
      @container = Container.find_by(id: params[:id],site_id: @site.id)
      redirect_to admin_errors_url(error_template: '403') unless @container
    end

    def set_new
      @container = Container.new
      @container.container_type = params[:container_type].present? ? params[:container_type] : nil
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def container_params
      params.require(:container).permit(
        :name,
        :site_id,
        :container_type,
        :navigation_id,
        :content_id,
        :image_id,
        :carousel_id,
        :rows_flag,
        :container_fluid,
        :container_css,
        :css_classes)
    end

end
