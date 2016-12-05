class Article < ApplicationRecord
  belongs_to :source
  belongs_to :category
  belongs_to :journalist

  has_many :topic_articles
  has_many :topics, through: :topic_articles
end
