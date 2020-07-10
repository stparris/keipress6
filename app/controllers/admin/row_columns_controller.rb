class Admin::RowColumnsController < AdminController
  before_action :set_row_column, only: [:show, :edit, :update, :destroy]
  before_action :set_new, only: [:new]

  layout 'admins'

  def sort
    params[:row_column].each_with_index do |id, index|
      item = RowColumn.find(id)
      item.update_attribute(:position, index + 1) if item
    end
    render body: nil
  end

  # GET /row_columns
  # GET /row_columns.json
  def index
    @row_columns = RowColumn.all
  end

  # GET /row_columns/1
  # GET /row_columns/1.json
  def show
  end

  # GET /row_columns/new
  def new
    if @row_column.content_type == 'grid_image_masonry'
      @row_column.grid_image_height = "250"
    end
  end

  # GET /row_columns/1/edit
  def edit
    if @row_column.content_type =~ /image_grid_fixed/
      @row_column.grid_columns = @row_column.content_type.split(/_/)[3]
    end
    if @row_column.content_type =~ /image_grid_masonry/
      @row_column.grid_image_height = @row_column.content_type.split(/_/)[3]
    end
  end

  # POST /row_columns
  # POST /row_columns.json
  def create
    @row_column = RowColumn.new(row_column_params)
    @container_row = @row_column.container_row
    respond_to do |format|
      begin
        @row_column.save
        flash[:success] = 'Column was successfully created.'
        format.html { redirect_to admin_row_column_url(@row_column) }
        format.json { render :show, status: :created, location: @row_column }
      rescue Exception, RowColumn::ExclusiveArcError => e
        flash[:danger] = "Error: #{e.message}"
        format.html { render :new }
        format.json { render json: @row_column.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /row_columns/1
  # PATCH/PUT /row_columns/1.json
  def update
    respond_to do |format|
      begin
        @row_column.update(row_column_params)
        flash[:success] = 'Column was successfully updated.'
        if @page
          format.html { redirect_to admin_page_url(@page) }
        else
          format.html { redirect_to admin_row_column_url(@row_column)  }
        end
        format.json { render :show, status: :ok, location: @row_column }
      rescue Exception, RowColumn::ExclusiveArcError => e
        flash[:danger] = "Error: #{e.message}"
        format.html { render :edit }
        format.json { render json: @row_column.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /row_columns/1
  # DELETE /row_columns/1.json
  def destroy
    @container_row =  @row_column.container_row
    @row_column.destroy
    respond_to do |format|
      flash[:success] = 'Column was successfully deleted.'
      format.html { redirect_to admin_container_row_url(@container_row) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_row_column
      @row_column = RowColumn.find(params[:id])
    end

    def set_new
      @container_row = ContainerRow.find(params[:container_row_id])
      @row_column = RowColumn.new
      @row_column.container_row = @container_row
      @row_column.content_type = params[:content_type].present? ? params[:content_type] : nil
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def row_column_params
      params.require(:row_column).permit(
        :name,
        :container_row_id,
        :css_classes,:content_type,
        :content_id,
        :category_id,
        :image_group_id,
        :carousel_id,
        :list_group_id,
        :grid_columns,
        :grid_image_height,
        :grid_break_point,
        :placeholder_flag)
    end

end
