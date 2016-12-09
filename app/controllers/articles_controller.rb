class ArticlesController < ApplicationController

  def index
    # session[:current_search] = params
    @topic_search = params[:topic_search]
    @stories = ::AylienAPI::GetStoriesService.new(topic_search: @topic_search).call

    @selected_stories = Article.random_sort(@stories)

    @selected_urls = []
    @selected_stories.each do |story|
      @selected_urls << story.links.permalink
    end
  end

end
