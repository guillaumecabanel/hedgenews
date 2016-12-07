class ArticlesController < ApplicationController

  def index
    # session[:current_search] = params
    @topic_search = params[:topic_search]
    @stories = ::AylienAPI::GetStoriesService.new(topic_search: @topic_search).call


  end

end
