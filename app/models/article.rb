class Article < ApplicationRecord
  belongs_to :source
  belongs_to :category
  belongs_to :journalist

  has_many :topic_articles
  has_many :topics, through: :topic_articles
  has_many :article_bookmarks

  def self.random_sort(articles, parameters = {})

    # articles.sort_by(:word_count)
    articles_quantity = parameters[:articles_quantity] || 10

    random_articles = []

    sources_id = []

    articles.each do |article|
      random_articles << article unless sources_id.include? article.source
      sources_id << article.source unless sources_id.include? article.source
    end

    random_articles.first(articles_quantity)
  end
end
