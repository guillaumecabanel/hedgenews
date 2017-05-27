class TopicArticlesController < ApplicationController

  def create
    # if Journalist.find_by_aylien_id(params[:journalist][:aylien_id])
    #   @journalist = Journalist.find_by_aylien_id(params[:journalist][:aylien_id])
    # else
    #   @journalist = Journalist.create!(journalist_params)
    # end

    # if Article.find_by_id(params[:article][:aylien_id])
      @article = Article.find_by_id(params[:article][:id])
    # else
    #   @article = Article.new(article_params)
    #   @article.journalist = @journalist
    #   @article.save
    # end

    @topic = Topic.find(params[:topic][:id])

    @topic_article = TopicArticle.new()
    @topic_article.article = @article
    @topic_article.topic = @topic
    @topic_article.save

  end

  def destroy
    @topic_article = TopicArticle.find(params[:topic_article_id])
    @topic = @topic_article.topic
    @topic_article.destroy
    @topic.update_sources_json
    @topic.update_number_of_sources
  end

  private
  def article_params
    params.require(:article).permit(:source_id, :title, :pic_url, :date, :abstract, :words_count, :aylien_id, :source_url, :opposite_url)
  end
  def journalist_params
    params.require(:journalist).permit(:last_name, :aylien_id)
  end

end
