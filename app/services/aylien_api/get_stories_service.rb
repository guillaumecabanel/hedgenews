module AylienAPI
  class GetStoriesService

    def initialize(params)
      @topic_search = params[:topic_search]

      @language =   params[:language]  || ['fr']
      @sources_id = params[:source_id] || [233, 1142, 1174, 641, 675, 642,
                                          1192, 684, 251, 1234, 1243, 1615]

      @sort_by =    params[:sorted_by] || 'published_at'
      @per_page =   params[:per_page]  || 20

      @parameters_to_return = ["id",
                               "title",
                               "body",
                               "summary",
                               "source",
                               "author",
                               "keywords",
                               "hashtags",
                               "words_count",
                               "categories",
                               "sentiment",
                               "language",
                               "published_at",
                               "links"]

      @api_instance = AylienNewsApi::DefaultApi.new
    end

    def call
      begin
        #List stories
        @api_instance.list_stories(options).stories

      rescue AylienNewsApi::ApiError => e
        puts "Exception when calling DefaultApi->list_stories: #{e}"
      end

    end

    private

    def options
      {
        title: @topic_search,
        published_at_start: "NOW-31DAYS",
        published_at_end: "NOW",
        language: @language,
        source_id: @sources_id,
        return: @parameters_to_return,
        sort_by: @sort_by,
        per_page: @per_page
      }
    end

  end
end
