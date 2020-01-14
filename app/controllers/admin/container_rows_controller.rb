class Admin::ContainerRowsController < AdminController
	before_action :set_container_row, only: [:show, :edit, :update, :destroy]
  before_action :set_new, only: [:new]

	layout 'admins'

  def sort
    params[:container_row].each_with_index do |id, index|
      item = ContainerRow.find(id)
      item.update_attribute(:position, index + 1) if item
    end
    render body: nil
  end

  # GET /container_rows
  # GET /container_rows.json
  def index
    @container_row = nil
    @container_rows =  @container ? ContainerRow.where(container_id: @container.id).order("position asc") : Container.where(site_id: @site.id)
  end

  # GET /container_rows/1
  # GET /container_rows/1.json
  def show
    @row_columns = @container_row.row_columns
  end

  # GET /container_rows/new
  def new
    @container_row = ContainerRow.new
    @container_row.container = @container
  end

  # GET /container_rows/1/edit
  def edit
  end

  # POST /container_rows
  # POST /container_rows.json
  def create
    @container_row = ContainerRow.new(container_row_params)
    respond_to do |format|
      if @container_row.save
        flash[:success] = 'Row was successfully created.'
        format.html { redirect_to admin_container_row_url(@container_row) }
        format.json { render :show, status: :created, location: @container_row }
      else
        set_new
        format.html { render :new }
        format.json { render json: @container_row.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /container_rows/1
  # PATCH/PUT /container_rows/1.json
  def update
    respond_to do |format|
      if @container_row.update(container_row_params)
        flash[:success] = 'Row was successfully updated.'
        if @page
          format.html { redirect_to admin_page_url(@page) }
        else
          format.html { redirect_to admin_container_row_url(@container_row) }
        end
        format.json { render :show, status: :ok, location: @container_row }
      else
        format.html { render :edit }
        format.json { render json: @container_row.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /container_rows/1
  # DELETE /container_rows/1.json
  def destroy
    @container = @container_row.container
    @container_row.destroy
    respond_to do |format|
      flash[:success] = 'Row was successfully deleted.' 
      format.html { redirect_to admin_container_url(@container) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
     def set_new
       @container = Container.find(params[:container_id])
       @container_row = ContainerRow.new
     end

    def set_container_row
      @container_row = ContainerRow.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def container_row_params
      params.require(:container_row).permit(:name,:container_id,:css_classes)
    end
end
