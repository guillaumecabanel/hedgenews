class AylienTestsController < ApplicationController

  def search
  end

  def results
    # session[:current_search] = params
    @topic = params[:topic]

    api_instance = AylienNewsApi::DefaultApi.new

    opts = {
      title: @topic,
      # published_at_start: "NOW-31DAYS",
      # published_at_end: "NOW",
      language: ['fr'],

      source_id: [233, 1142, 1174, 641, 675, 642,
                  1192, 684, 251, 1234, 1243, 1615],

      # source_name: [""],

      return: ["id", "title", "body", "summary", "source", "author", "keywords",
                  "hashtags", "words_count", "categories", "sentiment", "language", "published_at", "links"],
      sort_by: 'published_at',
      per_page: 20
    }

    begin
      #List stories
      @result = api_instance.list_stories(opts)
    rescue AylienNewsApi::ApiError => e
      puts "Exception when calling DefaultApi->list_stories: #{e}"
    end

  end

end
