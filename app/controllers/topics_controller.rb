class TopicsController < ApplicationController
  include ArticlesHelper

  def index
    @topics = current_user.topics
  end

  def show
    @topic = Topic.find(params[:id])
    @selected_articles = @topic.articles

    @selected_urls = []

    @topic.articles.each do |article|
      @selected_urls << article.source_url
    end
  end

  def create

    @topic = Topic.find_by_name(topic_params[:name])
    @topic.user = current_user
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

  def update
    @topic = Topic.find(params[:id])
    @topic.user = User.find_by_email("search@hedgenews.eu")
    @topic.save
  end

  def publish
    @topic = Topic.find(params[:id])
    @topic.user = User.find_by_email("hedgy@hedgenews.eu")
    @topic.save
    redirect_to root_path
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
