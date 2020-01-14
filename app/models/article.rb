class Article < Content

 	has_many :article_posts, -> { order(position: :asc) }, foreign_key: "content_id", class_name: "ArticlePost"

end
