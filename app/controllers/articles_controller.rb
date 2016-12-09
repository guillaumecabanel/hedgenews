class ArticlesController < ApplicationController

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

    @opposite_media = {}
    @opposite_media["Le Monde"] = "Valeurs Actuelles"
    @opposite_media["Le Figaro"] = "Médiapart"
    @opposite_media["Libération"] = "Les Echos"
    @opposite_media["Les Echos"] = "Libération"
    @opposite_media["L'Express"] = "Marianne"
    @opposite_media["Le Point"] = "Médiapart"
    @opposite_media["Marianne"] = "La Tribune"
    @opposite_media["La Croix"] = "Marianne"
    @opposite_media["La Tribune"] = "Marianne"
    @opposite_media["Médiapart"] = "Le Point"
    @opposite_media["Valeurs Actuelles"] = "Le Monde"

  end

end
