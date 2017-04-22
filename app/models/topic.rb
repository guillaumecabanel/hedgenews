class Topic < ApplicationRecord
  has_many :topic_articles, dependent: :destroy
  has_many :articles, through: :topic_articles
  belongs_to :user

  # Constants for Topic.get
  N_LATEST_STORIES = 5
  HASHTAGS_MIN_LENGTH = 5
  HASHTAGS_MAX_LENGTH = 20
  RELEVANCE_INDEX = 15
  OBSOLETE_TIME = 24 * 60 * 60


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
      # FIXME:
      # Save stories in DB to avoid API recall

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
          next if key_words.size >=  1
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
          if Topic.pluck(:name).include?(string_words)
            # Topic already exists:
            topic = Topic.find_by_name(string_words)
            if Time.now - Topic.find_by_name(string_words).articles.last.created_at > OBSOLETE_TIME
              # 1.1 topic updated more than 24h ago
                # new search
                topic.new_search
                true
            else
              # 1.2 topic updated less than 24h ago
              # update user from search to hedgy
              topic.user = User.find_by_email("hedgy@hedgenews.eu")
              topic.save
              true
            end
          else
            # create topic

            new_topic = Topic.new(name: string_words)
            new_topic.user = User.find_by_email("hedgy@hedgenews.eu")
            sources_array = new_topic.sort_by_source(results_for_hashtag).keys
            sources_hash = {sources: sources_array}

            new_topic.new_search
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

  # FIXME destroy this method ASAP (used in Topic.get with poor style)
  def story_opposite_url(story, source_urls)
    # name of the source of the story coming from API
    source_name = Source.where(aylien_id: story.source.id.to_i).first.name

    # find the names - there can be several - of the opposite media to the source of the story
    opposite_media = Article::OPPOSITE_MEDIA[source_name]
    return unless opposite_media

    opposite_media.each do |opposite_medium|
      opposite_url = source_urls[opposite_medium]
      return opposite_url if opposite_url
    end

    return nil
  end

  def sort_by_source(stories)

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

  # Oh la belle methode bien longue !
  def new_search
    stories = ::AylienAPI::GetStoriesService.new(topic_search: self.name).call
    unless stories.empty?
      hash_source_url = {}
      stories.each do |story|
        hash_source_url[Source.where(aylien_id: story.source.id.to_i).first.name] = story.links.permalink
      end

      stories.each do |story|
        next if story.media[0].url.empty?
        if Journalist.find_by_aylien_id(story.author.id)
          journalist = Journalist.find_by_aylien_id(story.author.id)
        else
          journalist = Journalist.create!(last_name: story.author.name, aylien_id: story.author.id)
        end
        article = Article.where(aylien_id: story.id).first
        unless article # check if story is already saved as an article in the DB
          article = Article.create!(
                               source_id: Source.where(aylien_id: story.source.id.to_i).first.id,
                               title: story.title,
                               pic_url: story.media[0].url,
                               date: story.published_at,
                               abstract: story.summary.sentences.join("\n"),
                               words_count: story.words_count,
                               aylien_id: story.id,
                               source_url: story.links.permalink,
                               opposite_url: story_opposite_url(story, hash_source_url),
                               journalist_id: Journalist.where(aylien_id: story.author.id).first.id,
                               hashtags: story.hashtags.join(" "),
          )
        end

        # possible that two articles have the same title but not the same source. Change code ? add a condition
        article_id_is_in_topic    = self.articles.pluck(:aylien_id).include?(article.aylien_id)
        article_title_is_in_topic = self.articles.pluck(:title).include?(article.title)
        unless article_id_is_in_topic || article_title_is_in_topic
          self.topic_articles.new(article: article, created_at: Time.current, updated_at: Time.current)
        end
      end

      self.find_image(stories)
      self.sources_json = { sources: hash_source_url.keys }.to_json.gsub("é", "e").gsub("É", "E")
      self.number_sources = JSON.parse(self.sources_json)["sources"].size
    end
    self.save
  end

  def find_image(stories)
    stories.reverse.each do |story|
      if story.media[0].url
        self.image_url = story.media[0].url
        break
      end
      self.image_url = image_path("hedgenews_meta_image")
    end
  end

end
