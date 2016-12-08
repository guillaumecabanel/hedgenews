module AylienAPI
  class GetTrendsService

    def initialize(params)

      @api_instance = AylienNewsApi::DefaultApi.new
    end



    def call
      begin
        #List trends
        @api_instance.list_trends(options)
      rescue AylienNewsApi::ApiError => e
        puts "Exception when calling DefaultApi->list_trends: #{e}"
      end
    end

    def options
      {
        categories_id: 'IAB11-4'
        # title: @topic_search,
        # published_at_start: @published_at_start,
        # published_at_end: @published_at_end,
        # language: @language,
        # source_id: @sources_id,
        # return: @parameters_to_return,
        # sort_by: @sort_by,
        # per_page: @per_page
      }
    end


  end
end
