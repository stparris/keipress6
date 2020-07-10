class Blog < Content

	has_many :blog_posts, -> { order(position: :asc) }, foreign_key: "content_id", class_name: "BlogPost"

  validates :name, presence: true
  validates :name, uniqueness: { scope: :site_id }
  validates :content_url, uniqueness: { scope: :site_id }

  before_save :gen_content_url

  def gen_content_url
    unless self.content_url =~ /\S+/
      # horrible name: %q#  ^This is a (sort of ["really"], kind of) {terrible} title! /m&m\ @ 50% #
      content_url = self.name.strip.gsub(/\@/," at ").gsub(/\&/," and ").gsub(/\%/," percent ").gsub(/[^A-Za-z0-9\s+]/,' ').gsub(/_|\./,'-')
      self.content_url = content_url.split(/\s+/).map(&:downcase).join('-').gsub(/-+/,"-").sub(/^-|-$/,'')
      # yields: "this-is-a-sort-of-really-kind-of-terrible-title-m-and-m-at-50-percent"
      # with parameterize: "this-is-a-sort-of-really-kind-of-terrible-title-m-m-50"
    end
  end


end
