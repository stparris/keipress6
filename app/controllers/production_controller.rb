class ProductionController < ApplicationController
  before_action :set_site
  before_action :set_locale
	
  protected
	  def set_site
	    @site = request.domain ? Site.joins(:domains).where("domains.name like ?", "#{request.domain}%").first : Site.first
	  end

	  def set_locale
	  	locale = request.fullpath.split(/-/)[0].sub(/\//,'').to_sym
	  	I18n.locale = I18n.available_locales.include?(locale) ? locale : 'en'.to_sym
	  end

end