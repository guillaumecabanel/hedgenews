class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index ]

  OBSOLETE_TIME = 24 * 60 * 60

  def index
    # session[:current_search] = params
    @topic_search = params[:topic_search]

    if Topic.pluck(:name).include?(@topic_search)
      # 1. topic already exists
      @topic = Topic.find_by_name(@topic_search)
        if Time.now - Topic.find_by_name(@topic_search).articles.last.created_at > OBSOLETE_TIME
          # 1.1 topic updated more than 24h ago
            # new search
            new_search(@topic, @topic_search)

            # display
            display_articles(@topic)
        else
          # 1.2 topic updated less than 24h ago
            # display existing articles (no new search)
            display_articles(@topic)
        end
    else
      # 2. topic doesn't exists
        # create topic
        @topic = Topic.new(name: @topic_search)
        @topic.user = User.find_by_email("search@hedgenews.eu")
        # new search
        new_search(@topic, @topic_search)
        # display
        display_articles(@topic)
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.topic_articles.destroy_all
  end

  private

  def new_search(topic, topic_search)
    @stories = ::AylienAPI::GetStoriesService.new(topic_search: topic_search).call
    unless @stories.empty?
      @hash_source_url = {}
      @stories.each do |story|
        @hash_source_url[Source.where(aylien_id: story.source.id.to_i).first.name] = story.links.permalink
      end

      @stories.each do |story|
        next if story.media[0].url.empty?
        if Journalist.find_by_aylien_id(story.author.id)
          @journalist = Journalist.find_by_aylien_id(story.author.id)
        else
          @journalist = Journalist.create!(last_name: story.author.name, aylien_id: story.author.id)
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
                               opposite_url: story_opposite_url(story, @hash_source_url),
                               journalist_id: Journalist.where(aylien_id: story.author.id).first.id,
                               hashtags: story.hashtags.join(" "),
          )
        end

        # possible that two articles have the same title but not the same source. Change code ? add a condition
        article_id_is_in_topic    = topic.articles.pluck(:aylien_id).include?(article.aylien_id)
        article_title_is_in_topic = topic.articles.pluck(:title).include?(article.title)
        unless article_id_is_in_topic || article_title_is_in_topic
          topic.topic_articles.new(article: article, created_at: Time.current, updated_at: Time.current)
        end
      end

      topic.image_url = @stories.last.media[0].url
      topic.sources_json = { sources: @hash_source_url.keys }.to_json.gsub("é", "e").gsub("É", "E")
      topic.number_sources = JSON.parse(@topic.sources_json)["sources"].size
    end
    topic.save
  end

  def display_articles(topic)
    # FIXME is `reverse` usefull?
    @articles = topic.articles.sort_by {|article| article.created_at}.reverse
    # FIXME revamp random_sort
    @selected_articles = Article.random_sort(@articles)
  end

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

end
