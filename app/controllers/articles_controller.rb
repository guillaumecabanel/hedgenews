class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index ]

  def index
    # session[:current_search] = params
    @topic_search = params[:topic_search]
    @stories = ::AylienAPI::GetStoriesService.new(topic_search: @topic_search).call

    @selected_stories = Article.random_sort(@stories)

    @selected_urls = []
    @hash_source_url = {}

    @selected_stories.each do |story|
      @selected_urls << story.links.permalink
      @hash_source_url[Source.where(aylien_id: story.source.id.to_i).first.name] = story.links.permalink
    end
  end
end
