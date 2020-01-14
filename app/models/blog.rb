class Blog < Content
	
	has_many :blog_posts, -> { order(position: :asc) }, foreign_key: "content_id", class_name: "BlogPost"

end
