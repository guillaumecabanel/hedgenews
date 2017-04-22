class Article < ApplicationRecord
  OPPOSITE_MEDIA = {
    "Marianne" => ["La Tribune", "Le Figaro", "Valeurs Actuelles", "Les Echos", "Le Point", "L'Express", "La Croix", "Le Monde"],
    "Libération" => ["Les Echos", "La Croix", "L'Express", "Le Point", "Valeurs Actuelles" "Le Figaro", "La Tribune", "Le Monde"],
    "Médiapart" => ["Le Point", "L'Express",  "La Croix", "Valeurs Actuelles", "Le Figaro", "Les Echos", "La Tribune", "Le Monde"],
    "Le Monde" => ["Valeurs Actuelles", "Le Figaro", "La Tribune", "Les Echos", "L'Express", "La Croix", "Le Point"],
    "L'Express" => ["Marianne", "Médiapart", "Libération", "Le Monde"],
    "Le Point" => ["Médiapart", "Libération", "Marianne", "Le Monde"],
    "La Tribune" => ["Marianne", "Médiapart", "Libération", "Le Monde"],
    "Les Echos" => ["Libération", "Médiapart", "Marianne", "Le Monde"],
    "La Croix" => ["Libération", "Marianne", "Médiapart", "Le Monde"],
    "Le Figaro" => ["Médiapart", "Marianne", "Libération", "Le Monde"],
    "Valeurs Actuelles" => ["Le Monde", "Marianne", "Libération", "Médiapart"]
  }

  belongs_to :source
  # belongs_to :category
  belongs_to :journalist

  has_many :topic_articles
  has_many :topics, through: :topic_articles
  has_many :article_bookmarks

  def self.random_sort(articles)
    # FIXME revamp random_sort to have only recent articles from each sources

    random_articles = []

    sources_id = []

    articles.each do |article|
      random_articles << article unless sources_id.include? article.source
      sources_id << article.source unless sources_id.include? article.source
    end

    random_articles
  end

end
