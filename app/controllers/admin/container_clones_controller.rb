class Admin::ContainerClonesController < AdminController
  before_action :set_container, only: [:new, :create]

  layout 'admins'

  # GET /Containers/new
  def new
    @container_clone.name = "Clone of #{@container.name}"
  end

  # POST /Containers
  # POST /Containers.json
  def create
    @container_clone.name = params[:container_clone][:name]
    respond_to do |format|
      if @container_clone.save
          @container.container_rows.each do |row|
          clone_row = ContainerRow.create!(container_id: @container_clone.id,css_classes: row.css_classes, position: row.position)
          row.row_columns.each do |col|
            clone_col = col.dup
            clone_col.container_row_id = clone_row.id
            clone_col.save
          end
        end
        flash[:success] = 'Container was successfully cloned.'
        format.html { redirect_to admin_container_url(@container_clone) }
        format.json { render :show, status: :created, location: @container_clone }
      else
        format.html { render :new }
        format.json { render json: @container_clone.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_container
      @container = Container.find(params[:container_id])
      @container_clone = @container.dup
      @container_clone.container_fluid = @container.css_classes =~ /container-fluid/ ? 'yes' : 'no' 
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def container_clone_params
      params.require(:container_clone).permit(:name)
    end	

end
