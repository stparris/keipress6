class ContactsController < ApplicationController
  before_action :set_mail_templates

  def create
    return_doc = {}
    return_doc['success'] = 'true'
    @contact = Contact.new(contact_params)
    respond_to do |format|
      begin
        html = @user_template.body_html.gsub(/\{\{first_name\}\}/,@contact.first_name)
        text = @user_template.body_text.gsub(/\{\{first_name\}\}/,@contact.first_name)
        html = html.gsub(/\{\{last_name\}\}/,@contact.last_name)
        text = text.gsub(/\{\{last_name\}\}/,@contact.last_name)
        mail_server = MailServer.find_by(site_id: @site.id, active: true)
        UserContactJob.perform_later(mail_server.id,@user_template.from_email,@contact.email,@user_template.subject,html,text)
        html = @admin_template.body_html.gsub(/\{\{first_name\}\}/,@contact.first_name)
        text = @admin_template.body_text.gsub(/\{\{first_name\}\}/,@contact.first_name)
        html = html.gsub(/\{\{last_name\}\}/,@contact.last_name)
        text = text.gsub(/\{\{last_name\}\}/,@contact.last_name)
        html = html.gsub(/\{\{email\}\}/,@contact.email)
        text = text.gsub(/\{\{email\}\}/,@contact.email)
        html = html.gsub(/\{\{details\}\}/,@contact.details)
        text = text.gsub(/\{\{details\}\}/,@contact.details)

        AdminContactJob.perform_later(mail_server.id,@admin_template.from_email,@admin_template.subject,html,text)
        format.json { render json: return_doc.to_json }
      rescue Exception => e
        return_doc['success'] = 'false'
        return_doc['message'] = e.message
        render json: return_doc.to_json
      end
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mail_templates
      @site = Site.find(params[:contact][:site_id])
      @user_template = MailTemplate.find_by(site_id: @site.id, locale: I18n.locale, recipient_type: 'user', template_type: 'contact')
      @admin_template = MailTemplate.find_by(site_id: @site.id, recipient_type: 'admin', template_type: 'contact')
    end

    def contact_params
      params.require(:contact).permit(:site_id, :first_name, :last_name, :email, :details)
    end

end
