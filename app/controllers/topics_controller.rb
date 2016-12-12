class TopicsController < ApplicationController
  include ArticleHelper

  def index
    @topics = current_user.topics
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
      article = Article.where(aylien_id: story.id).first

      unless article
        article = Article.create(source_id: Source.where(aylien_id: story.source.id.to_i).first.id,
                                 title: story.title,
                                 pic_url: story.media[0].url,
                                 date: story.published_at,
                                 abstract: story.summary.sentences.join("\n"),
                                 words_count: story.words_count,
                                 aylien_id: story.id,
                                 source_url: story.links.permalink,
                                 opposite_url: story_opposite_url(story, @hash_source_url),
                                 )
      end

      @topic.topic_articles.new(article: article)
    end

    # faire la topic image url
    @topic.image_url = @stories.first.media[0].url
    @topic.sources_json = { sources: @hash_source_url.keys }.to_json.gsub("é", "e")
    @topic.save
    @topic.number_sources = JSON.parse(@topic.sources_json)["sources"].size
    @topic.save
    redirect_to topics_path
  end

  def destroy
  end

  private
  def topic_params
    params.require(:topic).permit(:name)
  end

end
