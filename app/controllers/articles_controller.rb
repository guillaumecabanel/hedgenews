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
            @topic.new_search

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
        @topic.new_search
        # display
        display_articles(@topic)
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.topic_articles.destroy_all
  end

  private

  def display_articles(topic)
    # FIXME is `reverse` usefull?
    @articles = topic.articles.sort_by {|article| article.created_at}.reverse
    # FIXME revamp random_sort
    @selected_articles = Article.random_sort(@articles)
  end

end
