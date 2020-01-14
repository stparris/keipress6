class Admin::DomainsController < AdminController
  before_action :set_domain, only: [:show, :edit, :update, :destroy]

  layout 'admins'
  
  # GET /domains
  # GET /domains.json
  def index
    @domains = Domain.all
  end

  # GET /domains/1
  # GET /domains/1.json
  def show
  end

  # GET /domains/new
  def new
    @domain = Domain.new
  end

  # GET /domains/1/edit
  def edit
  end

  # POST /domains
  # POST /domains.json
  def create
    @domain = Domain.new(domain_params)

    respond_to do |format|
      begin
        if @domain.save
          flash[:success] = 'Domain was successfully created.'
          format.html { redirect_to admin_domain_url(@domain) }
          format.json { render :show, status: :created, location: @domain }
        else
          format.html { render :new }
          format.json { render json: @domain.errors, status: :unprocessable_entity }
        end
      rescue Exception => e 
        flash[:danger] = "Oops! Something went wrong: #{e.message}"
        format.html { render :new }
      end        
    end
  end

  # PATCH/PUT /domains/1
  # PATCH/PUT /domains/1.json
  def update
    respond_to do |format|
      begin
        if @domain.update(domain_params)
          flash[:success] = 'Domain was successfully updated.'
          format.html { redirect_to admin_domain_url(@domain) }
          format.json { render :show, status: :ok, location: @domain }
        else
          format.html { render :edit }
          format.json { render json: @domain.errors, status: :unprocessable_entity }
        end
      rescue Exception => e 
        flash[:danger] = "Oops! Something went wrong: #{e.message}"
        format.html { render :new }
      end    
    end
  end

  # DELETE /domains/1
  # DELETE /domains/1.json
  def destroy
    respond_to do |format|
      begin
        if @domain.destroy
          flash[:success] = 'Domain was successfully removed.'
          format.html { redirect_to admin_domains_url }
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
    def set_domain
      @domain = Domain.find_by(id: params[:id],site_id: @site.id)
      redirect_to admin_errors_url(error_template: '403') unless @domain
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def domain_params
      params.require(:domain).permit(:name,:site_id)
    end
end
