class Topic < ApplicationRecord
  has_many :topic_articles
  has_many :articles, through: :topic_articles
end
