class Admin::WatermarksController < AdminController
  before_action :set_watermark, only: [:show, :edit, :update, :destroy]

  layout 'admins'

  # GET /watermarks
  # GET /watermarks.json
  def index
    @watermarks = Watermark.where(site_id: @site.id).order('name asc')
  end

  # GET /watermarks/1
  # GET /watermarks/1.json
  def show

  end

  # GET /watermarks/new
  def new
    @watermark = Watermark.new
  end

  # GET /watermarks/1/edit
  def edit
  end

  # POST /watermarks
  # POST /watermarks.json
  def create
    @watermark = Watermark.new(watermark_params)
    respond_to do |format|
      if @watermark.save
        flash[:success] = 'Watermark was successfully created.'
        format.html { redirect_to admin_watermark_url(@watermark) }
        format.json { render :show, status: :created, location: @watermark }
      else
        format.html { render :new }
        format.json { render json: @watermark.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /watermarks/1
  # PATCH/PUT /watermarks/1.json
  def update
    respond_to do |format|
      begin
        if @watermark.update(watermark_params)
          flash[:success] = 'Watermark was successfully updated.'
          format.html { redirect_to admin_watermark_url(@watermark) }
          format.json { render :show, status: :ok, location: @watermark }
        else
          format.html { render :edit }
          format.json { render json: @watermark.errors, status: :unprocessable_entity }
        end
      rescue Exception => e
        flash[:danger] = "Oops! Something went wrong: #{e.message}"
        format.html { render :edit }
      end
    end
  end

  # DELETE /watermarks/1
  # DELETE /watermarks/1.json
  def destroy
    respond_to do |format|
      begin
        if @watermark.destroy
          flash[:success] = 'Watermark was successfully removed.'
          format.html { redirect_to admin_watermarks_url }
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
    def set_watermark
      # @watermark = watermark.find_by(id: params[:id],site_id: @site.id)
      @watermark = Watermark.find(params[:id])
      redirect_to admin_errors_url(error_template: '403') unless @watermark
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def watermark_params
      params.require(:watermark).permit(
        :site_id,
        :name,
        :watermark_type,
        :text,
        :image,
        :font,
        :color,
        :opacity,
        :rotate,
        :margin,
        :orientation,
        :size)
    end
end
