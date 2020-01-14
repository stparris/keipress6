class RentalBookingJob < ApplicationJob
  queue_as :rental_booking
  require 'mail'
  include MailTemplatesHelper
  
  def perform(mail_server,booking)
  	require 'mail'
  	mail_server_conn = mail_server.connection_config
  	Mail.defaults do
		  delivery_method :smtp, mail_server_conn
		end
		
		from_email = booking.payment_method.user_mail_template.from_email
		to_email = booking.user.email
		subject = process_mail_macros(booking.payment_method.user_mail_template.subject,[booking,booking.rental,booking.user])
		html = process_mail_macros(booking.payment_method.user_mail_template.body_html,[booking,booking.rental,booking.user])
		text = process_mail_macros(booking.payment_method.user_mail_template.body_text,[booking,booking.rental,booking.user])
  	send_mail(to_email,from_email,subject,html,text)

  	from_email = booking.payment_method.user_mail_template.from_email
		subject = process_mail_macros(booking.payment_method.admin_mail_template.subject,[booking,booking.rental,booking.user])
		html = process_mail_macros(booking.payment_method.admin_mail_template.body_html,[booking,booking.rental,booking.user])
		text = process_mail_macros(booking.payment_method.admin_mail_template.body_text,[booking,booking.rental,booking.user])
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

