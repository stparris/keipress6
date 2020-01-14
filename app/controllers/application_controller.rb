class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def show_debug(from)
    session_str = "\nsession data:\n"
    session.each do |name|
      session_str += "#{name}: #{session[name]}\n"
    end
    logger.info "
===================================== 
  domain: #{request.domain}
  site: #{@site ? @site.name : 'not set'}
  uri: #{request.fullpath}
  original_url: #{request.original_url}
  filter: #{from}
  #{session_str}
=====================================
"  
	end

end
