class Admin::MailTemplatesController < AdminController
  before_action :set_mail_template, only: [:show, :edit, :update, :destroy]

  layout 'admins'

  # GET /mail_templates
  # GET /mail_templates.json
  def index
    @mail_templates = MailTemplate.where(site_id: @site.id).order('name asc')
  end

  # GET /mail_templates/1
  # GET /mail_templates/1.json
  def show
  end

  # GET /mail_templates/new
  def new
    @mail_template = MailTemplate.new
  end

  # GET /mail_templates/1/edit
  def edit
  end

  # POST /mail_templates
  # POST /mail_templates.json
  def create
    @mail_template = MailTemplate.new(mail_template_params)
    respond_to do |format|
      if @mail_template.save
        flash[:success] = 'Mail template was successfully created.'
        format.html { redirect_to admin_mail_template_url(@mail_template) }
        format.json { render :show, status: :created, location: @mail_template }
      else
        format.html { render :new }
        format.json { render json: @mail_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mail_templates/1
  # PATCH/PUT /mail_templates/1.json
  def update
    respond_to do |format|
      if @mail_template.update(mail_template_params)
        flash[:success] = 'Mail template was successfully updated.'
        format.html { redirect_to admin_mail_template_url(@mail_template) }
        format.json { render :show, status: :ok, location: @mail_template }
      else
        format.html { render :edit }
        format.json { render json: @mail_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mail_templates/1
  # DELETE /mail_templates/1.json
  def destroy
    @mail_template.destroy
    respond_to do |format|
      format.html { redirect_to admin_mail_templates_url, notice: 'Mail template was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mail_template
      @mail_template = MailTemplate.find_by(id: params[:id],site_id: @site.id)
      redirect_to admin_errors_url(error_template: '403') unless @mail_template
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mail_template_params
      params.require(:mail_template).permit(
        :name,
        :site_id,
        :from_email,
        :recipient_type,
        :template_type,
        :locale,
        :subject,
        :body_html,
        :body_text)
    end
end
