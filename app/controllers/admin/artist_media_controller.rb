class ArtistMediaController < AdminController
  before_action :set_artist_medium, only: [:show, :edit, :update, :destroy]

  # GET /artist_mediums
  # GET /artist_mediums.json
  def index
    @artist_mediums = ArtistMedia.all
  end

  # GET /artist_mediums/1
  # GET /artist_mediums/1.json
  def show
  end

  # GET /artist_mediums/new
  def new
    @artist_medium = ArtistMedia.new
  end

  # GET /artist_mediums/1/edit
  def edit
  end

  # POST /artist_mediums
  # POST /artist_mediums.json
  def create
    @artist_medium = ArtistMedia.new(artist_medium_params)

    respond_to do |format|
      if @artist_medium.save
        format.html { redirect_to @artist_medium, notice: 'Artist was successfully created.' }
        format.json { render :show, status: :created, location: @artist_medium }
      else
        format.html { render :new }
        format.json { render json: @artist_medium.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /artist_mediums/1
  # PATCH/PUT /artist_mediums/1.json
  def update
    respond_to do |format|
      if @artist_medium.update(artist_medium_params)
        format.html { redirect_to @artist_medium, notice: 'Artist was successfully updated.' }
        format.json { render :show, status: :ok, location: @artist_medium }
      else
        format.html { render :edit }
        format.json { render json: @artist_medium.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /artist_mediums/1
  # DELETE /artist_mediums/1.json
  def destroy
    @artist_medium.destroy
    respond_to do |format|
      format.html { redirect_to artist_mediums_url, notice: 'Artist was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_artist_medium
      @artist_medium = ArtistMedia.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def artist_medium_params
      params.require(:artist_medium).permit(:admin_id,:medium_id)
    end
end
