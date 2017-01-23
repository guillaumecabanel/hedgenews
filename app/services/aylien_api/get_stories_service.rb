module AylienAPI
  class GetStoriesService

    def initialize(params)
      @topic_search = params[:topic_search]

      @language =   params[:language]  || ['fr']
      @sources_id = params[:source_id] || [233, 1142, 1174, 641, 675,
                                          1192, 684, 251, 1234, 1243, 1615]

      # "l'express":    233,
      # "la croix":     1142,
      # "la tribune":   1174,
      # "le figaro":    641,
      # "le monde":     675,
      # "le parisien":  642,
      # "le point":     1192,
      # "les échos":    684,
      # "libération":   251,
      # "marianne":     1234,
      # "mediapart":    1243,
      # "valeurs actuelles": 1615

      #Opposite media :
      # "marianne":     gauche dure           la tribune
      # "libération":   gauche                les échos
      # "mediapart":    gauche                le figaro
      # "la croix":     droite                marianne
      # "le monde":     centre                valeurs actuelles
      # "la tribune":   droite                marianne
      # "les échos":    droite                libération
      # "le point":     droite                médiapart
      # "l'express":    droite                marianne
      # "le figaro":    droite                médiapart
      # "valeurs actuelles": extreme droite   le monde

      @published_at_start = params[:published_at_start] || "NOW-10DAYS"
      @published_at_end = params[:published_at_end] || "NOW"

      @sort_by =    params[:sorted_by] || "relevance"

      # sort_by: [default to published_at]
      # Other possible values:
      # relevance, recency, hotness, published_at, social_shares_count,
      # social_shares_count.facebook, social_shares_count.linkedin,
      # social_shares_count.google_plus, social_shares_count.reddit,
      # media.images.count, media.videos.count


      @per_page =   params[:per_page]  || 20
      @media_images_width_min = params[:media_images_width_min] || 523

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
                               "media",
                               "links"]

      @api_instance = AylienNewsApi::DefaultApi.new
    end

    def call
      begin
        # List stories
        result = @api_instance.list_stories_with_http_info(options)

        # Limite rate message
        puts 'API called successfully. Rate limit headers are as follows:'
        puts "X-RateLimit-Limit: #{result[2]['X-RateLimit-Limit']}"
        puts "X-RateLimit-Remaining: #{result[2]['X-RateLimit-Remaining']}"
        puts "X-RateLimit-Reset: #{result[2]['X-RateLimit-Reset']}"

        return result.first.stories

      rescue AylienNewsApi::ApiError => e
        puts "Exception when calling DefaultApi->list_stories: #{e}"
        return []
      end

    end

    private

    def options
      {
        title: @topic_search,
        published_at_start: @published_at_start,
        published_at_end: @published_at_end,
        language: @language,
        source_id: @sources_id,
        media_images_width_min: @media_images_width_min,
        return: @parameters_to_return,
        sort_by: @sort_by,
        per_page: @per_page
      }
    end

  end
end
