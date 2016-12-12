class Article < ApplicationRecord
  OPPOSITE_MEDIA = {
    "L'Express" => ["Marianne", "Médiapart", "Libération"],
    "La Croix" => ["Marianne", "Médiapart", "Libération"],
    "La Tribune" => ["Marianne", "Médiapart", "Libération"],
    "Le Figaro" => ["Médiapart", "Marianne", "Libération"],
    "Le Monde" => ["Valeurs Actuelles", "Le Figaro", "Le Point"],
    "Le Point" => ["Médiapart", "Marianne", "Libération"],
    "Les Echos" => ["Libération"],
    "Libération" => ["Les Echos", "Le Figaro"],
    "Marianne" => ["La Tribune"],
    "Médiapart" => ["Le Point"],
    "Valeurs Actuelles" => ["Le Monde"]
  }

  belongs_to :source
  # belongs_to :category
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
