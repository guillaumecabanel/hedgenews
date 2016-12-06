class AylienTestsController < ApplicationController

  def search
  end

  def results
    @topic_search = params[:topic_search]
    @stories = ::AylienAPI::GetStoriesService.new(topic_search: @topic_search).call
  end
end
