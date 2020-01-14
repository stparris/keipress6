class Admin::MailServersController < AdminController
  before_action :set_mail_server, only: [:show, :edit, :update, :destroy]

 layout 'admins'

  # GET /mail_servers
  # GET /mail_servers.json
  def index
    @mail_servers = MailServer.find_by_site_id(@site.id)
  end

  # GET /mail_servers/1
  # GET /mail_servers/1.json
  def show
  end

  # GET /mail_servers/new
  def new
    @mail_server = MailServer.new
  end

  # GET /mail_servers/1/edit
  def edit
  end

  # POST /mail_servers
  # POST /mail_servers.json
  def create
    @mail_server = MailServer.new(mail_server_params)
    MailServer.where(site_id: @site.id).update_all(active: false)
    respond_to do |format|
      if @mail_server.save
        flash[:success] =  'Mail server was successfully created.'
        format.html { redirect_to admin_mail_servers_url(@mail_server) }
        format.json { render :show, status: :created, location: @mail_server }
      else
        format.html { render :new }
        format.json { render json: @mail_server.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mail_servers/1
  # PATCH/PUT /mail_servers/1.json
  def update
    respond_to do |format|
      # MailServer.where(site_id: @site.id).update_all(active: false)
      if @mail_server.update(mail_server_params)
        flash[:success] =  'Mail server was successfully updated.'
        format.html { redirect_to admin_mail_servers_url(@mail_server) }
        format.json { render :show, status: :ok, location: @mail_server }
      else
        format.html { render :edit }
        format.json { render json: @mail_server.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mail_servers/1
  # DELETE /mail_servers/1.json
  def destroy
    @mail_server.destroy
    flash[:success] = 'Mail server was successfully deleted.'
    respond_to do |format|
      format.html { redirect_to admin_mail_servers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mail_server
      @mail_server = MailServer.find_by(id: params[:id],site_id: @site.id)
      redirect_to admin_errors_url(error_template: '403') unless @mail_server
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mail_server_params
      params.require(:mail_server).permit(:name,:site_id,:config,:active)
    end
end
