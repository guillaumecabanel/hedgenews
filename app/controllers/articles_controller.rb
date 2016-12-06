class ArticlesController < ApplicationController

  def index
    session[:current_search] = params
    @topic = params[:topic]

    api_instance = AylienNewsApi::DefaultApi.new

    opts = {
      title: @topic,
      # published_at_start: "NOW-31DAYS",
      # published_at_end: "NOW",
      language: ['fr'],
      source_name: ["Libération", "Le Monde", "Le Figaro", "L'Express",
                    "Le Parisien", "L'Humanité", "Nouvel Obs", "Le Point",
                    "La Tribune", "Les Echos", "Marianne", "Le Canard Enchaîné",
                    "La Croix", "20 Minutes", "Valeurs Actuelles"],
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
