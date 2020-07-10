class Admin::SiteTagsController < AdminController
  before_action :set_site_tag, only: [:show, :edit, :update, :destroy]

  layout 'admins'

  def sort
    params[:site_tag].each_with_index do |id, index|
      item = SiteTag.find(id)
      item.update_attribute(:position, index + 1) if item
    end
    render body: nil
  end


  # GET /site_tags
  # GET /site_tags.json
  def index
  end

  # GET /site_tags/1
  # GET /site_tags/1.json
  def show
  end

  # GET /site_tags/new
  def new
    @site_tag = SiteTag.new(site_id: @site.id)
  end

  # GET /site_tags/1/edit
  def edit
  end

  # POST /site_tags
  # POST /site_tags.json
  def create
    @site_tag = SiteTag.new(site_tag_params)

    respond_to do |format|
      if @site_tag.save
        format.html { redirect_to @site_tag, notice: 'Site tag was successfully created.' }
        format.json { render :show, status: :created, location: @site_tag }
      else
        format.html { render :new }
        format.json { render json: @site_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /site_tags/1
  # PATCH/PUT /site_tags/1.json
  def update
    respond_to do |format|
      if @site_tag.update(site_tag_params)
        format.html { redirect_to @site_tag, notice: 'Site tag was successfully updated.' }
        format.json { render :show, status: :ok, location: @site_tag }
      else
        format.html { render :edit }
        format.json { render json: @site_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /site_tags/1
  # DELETE /site_tags/1.json
  def destroy
    @site_tag.destroy
    respond_to do |format|
      format.html { redirect_to site_tags_url, notice: 'Site tag was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_site_tag
      @site_tag = SiteTag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def site_tag_params
      params.fetch(:site_tag, {})
      params.require(:site_tag).permit(
        :name,
        :tag_type,
        :value,
        :position,
        :site_id)
    end
end
