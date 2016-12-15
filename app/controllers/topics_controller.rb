class TopicsController < ApplicationController
  include ArticlesHelper

  def index
    @topics = current_user.topics
  end

  def show
    @topic = Topic.find(params[:id])

    @selected_urls = []

    @topic.articles.each do |article|
      @selected_urls << article.source_url
    end
  end

  def create

    @topic = Topic.new(topic_params)
    @topic.user = current_user

    @stories = ::AylienAPI::GetStoriesService.new(topic_search: topic_params[:name]).call

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
                                 opposite_url: story_opposite_url(story, @hash_source_url),
                                 journalist_id: Journalist.where(aylien_id: story.author.id).first.id,
                                 )
      end
      @topic.topic_articles.new(article: article)
    end

    # faire la topic image url
    if @stories.first.media[0].url.empty?
      @topic.image_url = @stories.last.media[0].url
    else
      @topic.image_url = @stories.first.media[0].url
    end
    @topic.sources_json = { sources: @hash_source_url.keys }.to_json.gsub("é", "e").gsub("É", "E")
    @topic.save
    @topic.number_sources = JSON.parse(@topic.sources_json)["sources"].size
    @topic.save
    redirect_to topics_path
  end

  def edit
    @topic = Topic.find(params[:id])
    @articles = []
    topic_articles =  @topic.topic_articles.order(:created_at).reverse
    topic_articles.each do |topic_article|
      @articles << topic_article.article
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
  end

  private
  def topic_params
    params.require(:topic).permit(:name)
  end

end
