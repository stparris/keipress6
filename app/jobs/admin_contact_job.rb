class AdminContactJob < ApplicationJob
  queue_as :user_contact
  require 'mail'

  def perform(mail_server_id,from_email,subject,html,text)
  	require 'mail'
    mail_server = MailServer.find(mail_server_id)
  	mail_server_conn = mail_server.connection_config
  	Mail.defaults do
		  delivery_method :smtp, mail_server_conn
		end

  	mail_server.site.admins.each do |admin|
	  	send_mail(admin.email,from_email,subject,html,text)
	  end
	end

  def send_mail(to_email,from_email,subject,html,text)
		begin
			mail = Mail.new
			mail[:to] = to_email
			mail[:from] = from_email
			mail.subject = subject

			text_part = Mail::Part.new
			text_part.body = text

			html_part = Mail::Part.new
			html_part.content_type = 'text/html; charset=UTF-8'
			html_part.body = html

			mail.text_part = text_part
			mail.html_part = html_part
			mail.deliver
		rescue Exception => e
			open("log/delayed_job_error.log", 'a') do |f|
				f.puts "\n#{Time.now} : #{to_email} #{e.message}"
			end
		end
  end

end

