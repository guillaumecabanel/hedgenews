class Topic < ApplicationRecord
  has_many :topic_articles, dependent: :destroy
  has_many :articles, through: :topic_articles
  belongs_to :user

  # Constants for Topic.get
  N_LATEST_STORIES = 5
  HASHTAGS_MIN_LENGTH = 5
  HASHTAGS_MAX_LENGTH = 20
  RELEVANCE_INDEX = 15

  def self.get
    topics = []

    # Main sources:
    # "libération":   251
    # "le figaro":    641,
    # "le monde":     675,
    # "les échos":    684,

    # Get the N lastest stories from each sources
    sources_id = [251, 641, 675, 684]
    sorted_stories = {}

    sources_id.each do |source_id|
      stories = ::AylienAPI::GetStoriesService.new(source_id: source_id,sorted_by: "published_at", per_page: N_LATEST_STORIES).call
      source = stories.first.source.name
      sorted_stories[source] = stories
    end

    sorted_stories.each do |source, stories|
      puts "#{source} : #{stories.count} articles"
    end

    sorted_stories.each do |source, stories|

      # For each source, find the first story with an hashtag that could get more than 20 stories has a search
      stories.find do |story|
        next if story.hashtags.empty?
        key_words = []
        story.hashtags.each do |hashtag|

          next if hashtag.length < HASHTAGS_MIN_LENGTH || hashtag.length > HASHTAGS_MAX_LENGTH
          next if key_words.size >=  2
          # remove the'#' from the hashtag
          clean_words = hashtag[1..-1]

          # transform 'CamelCase' to 'String with spaces'
          string_words = clean_words.gsub(/([A-ZÉ]+)([A-ZÉ][a-z])/,'\1 \2').gsub(/([a-z\d])([A-ZÉ])/,'\1 \2')

          key_words << string_words
        end

        string_words = key_words.join(' ')

        # Number of results for this search
        results_for_hashtag = ::AylienAPI::GetStoriesService.new(topic_search: string_words).call

        # Keep only stories with at least one hashtag in common
        results_with_common_hashtag = []

        results_for_hashtag.each do |story_canditate|
          common_hashtag = false
          story_canditate.hashtags.each do |hashtag|
            next if common_hashtag
            if story.hashtags.include? hashtag
              common_hashtag = true
            end
          end
          results_with_common_hashtag << story_canditate if common_hashtag
        end

        # Test relevance
        related_stories = results_with_common_hashtag.count
        if related_stories > RELEVANCE_INDEX
          if topics.find {|topic| topic.name == string_words}
            false # Topic already exists: keep trying to find relevant topic
          else
            # Record topic
            sources_array = sort_by_source(results_for_hashtag).keys
            sources_hash = {sources: sources_array}

            new_topic = Topic.new(name: string_words,
                                  user: User.find_by_email('hedgy@hedgenews.eu'),
                                  number_sources: sources_array.count,
                                  image_url: story.media[0].url,
                                  sources_json: JSON.generate(sources_hash)
                                  # TODO: Save articles
                                  )
            new_topic.save

            topics << new_topic
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
end
