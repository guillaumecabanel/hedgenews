class ArticlesController < ApplicationController

  def index
    @topic_search = params[:topic_search]
    @stories = ::AylienAPI::GetStoriesService.new(topic_search: @topic_search).call

    @selected_stories = Article.random_sort(@stories)
  end

end
