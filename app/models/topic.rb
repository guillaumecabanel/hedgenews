class Topic < ApplicationRecord
  has_many :topic_articles
  has_many :articles, through: :topic_articles


  def self.get

    topics = []

    stories = ::AylienAPI::GetStoriesService.new(source_id: [675, 641, 251, 684], sorted_by: "published_at").call
    # "le figaro":    641,
    # "le monde":     675,
    # "les échos":    684,
    # "libération":   251

    sorted_stories = sort_by_source(stories)

    sorted_stories.each do |source, stories|

      # For each source, find the first storie with an hashtag that could get more than 20 stories has a search
      stories.find do |story|
        next if story.hashtags.empty?

        # remove the'#' from the hashtag
        clean_words = story.hashtags.first[1..-1]

        next if clean_words.length > 20

        # transform 'CamelCase' to 'String with spaces'
        string_words = clean_words.gsub(/([A-ZÉ]+)([A-ZÉ][a-z])/,'\1 \2').gsub(/([a-z\d])([A-ZÉ])/,'\1 \2')

        # Number of results for this search
        related_stories = ::AylienAPI::GetStoriesService.new(topic_search: string_words).call.count

        if related_stories > 19
          if topics.find {|topic| topic.name == string_words}
            false # Topic already exists: keep trying to find relevant topic
          else
            topics << Topic.new(name: string_words)
            true
          end
        else
          false
        end
      end

    end

    topics
  end


  def self.sort_by_source(stories)

    stories_by_source = {}

    stories.each do |story|
      if stories_by_source.key? story.source.name
        stories_by_source[story.source.name] << story
      else
        stories_by_source[story.source.name] = [story]
      end

    end
    stories_by_source
  end

  # @hashtags = []

  # first_articles = []

  # sources_id = []

  # @stories.each do |article|
  #   first_articles << article unless sources_id.include? article.source
  #   sources_id << article.source unless sources_id.include? article.source
  # end

  # first_articles.each do |story|
  #     @hashtags  << story.source.name
  #     story.hashtags.each_with_index do |h, index|
  #       next if index > 2
  #       @hashtags <<  h unless h.length > 20
  #     end
  # end

  # + les echos

  # on prend une source
    # on prend le premier article // hotness
      # on prend le premier hashtag
      # si > 10 articles => topic
      # sinon on passe à l'article suivant de la source
  # on passe à la source suivante

end
