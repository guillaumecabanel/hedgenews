class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index ]

  def index
    # session[:current_search] = params
    @topic_search = params[:topic_search]

    if Topic.pluck(:name).include?(@topic_search)
      @articles = Topic.find_by_name(@topic_search).articles
      @selected_articles = Article.random_sort(@articles)

    else
      @topic = Topic.new(name: @topic_search)
      @topic.user = User.find_by_email("hedgy@hedgenews.eu")

      @stories = ::AylienAPI::GetStoriesService.new(topic_search: @topic_search).call

      @hash_source_url = {}
      @stories.each do |story|
        @hash_source_url[Source.where(aylien_id: story.source.id.to_i).first.name] = story.links.permalink
      end

      @stories.each do |story|
        if Journalist.find_by_aylien_id(story.author.id)
          @journalist = Journalist.find_by_aylien_id(story.author.id)
        else
          @journalist = Journalist.create!(last_name: story.author.name, aylien_id: story.author.id)
        end
        article = Article.where(aylien_id: story.id).first
        unless article
          article = Article.create!(source_id: Source.where(aylien_id: story.source.id.to_i).first.id,
                                   title: story.title,
                                   pic_url: story.media[0].url,
                                   date: story.published_at,
                                   abstract: story.summary.sentences.join("\n"),
                                   words_count: story.words_count,
                                   aylien_id: story.id,
                                   source_url: story.links.permalink,
                                   # opposite_url: story_opposite_url(story, @hash_source_url),
                                   journalist_id: Journalist.where(aylien_id: story.author.id).first.id,
                                   )
        end
        @topic.topic_articles.new(article: article, created_at: Time.current, updated_at: Time.current)
      end

      unless @stories = []
        if @stories.first.media[0].url.empty?
          @topic.image_url = @stories.last.media[0].url
        else
          @topic.image_url = @stories.first.media[0].url
        end
      end

      @topic.sources_json = { sources: @hash_source_url.keys }.to_json.gsub("é", "e").gsub("É", "E")
      @topic.save
      @topic.number_sources = JSON.parse(@topic.sources_json)["sources"].size
      @topic.save

      @articles = @topic.articles
      @selected_articles = Article.random_sort(@articles)
    end

    # @stories = ::AylienAPI::GetStoriesService.new(topic_search: @topic_search).call
    # @selected_stories = Article.random_sort(@stories)
    # @selected_urls = []
    # @hash_source_url = {}

    # @selected_stories.each do |story|
    #   @selected_urls << story.links.permalink
    #   @hash_source_url[Source.where(aylien_id: story.source.id.to_i).first.name] = story.links.permalink
    # end

  end

  def destroy
    @article = Article.find(params[:id])
    @article.topic_articles.destroy_all
  end

end
