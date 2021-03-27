class SiteTag < ApplicationRecord
  belongs_to :site
  before_create :set_position

  def self.tag_types
    {'Meta'=>'meta','Link'=>'link','Style'=>'style','Script'=>'script'}
  end

  def set_position
    self.position = SiteTag.where(site_id: self.site_id).count + 1
  end

end
