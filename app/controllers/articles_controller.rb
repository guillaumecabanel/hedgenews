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
    if @hash_source_url["Valeurs Actuelles"] != nil
      @opposite_media["Le Monde"] = "Valeurs Actuelles"
    elsif @hash_source_url["Le Figaro"] != nil
      @opposite_media["Le Monde"] = "Le Figaro"
    else
      @opposite_media["Le Monde"] = "Le Point"
    end

    if @hash_source_url["Médiapart"] != nil
      @opposite_media["Le Figaro"] = "Médiapart"
    elsif @hash_source_url["Marianne"] != nil
      @opposite_media["Le Figaro"] = "Marianne"
    else
      @opposite_media["Le Figaro"] = "Libération"
    end

    @opposite_media["Libération"] = "Les Echos"
    @opposite_media["Les Echos"] = "Libération"

    if @hash_source_url["Marianne"] != nil
      @opposite_media["L'Express"] = "Marianne"
    elsif @hash_source_url["Médiapart"] != nil
      @opposite_media["L'Express"] = "Médiapart"
    else
      @opposite_media["L'Express"] = "Libération"
    end

    if @hash_source_url["Médiapart"] != nil
      @opposite_media["Le Point"] = "Médiapart"
    elsif @hash_source_url["Marianne"] != nil
      @opposite_media["Le Point"] = "Marianne"
    else
      @opposite_media["Le Point"] = "Libération"
    end

    @opposite_media["Marianne"] = "La Tribune"

    if @hash_source_url["Marianne"] != nil
      @opposite_media["La Croix"] = "Marianne"
    elsif @hash_source_url["Médiapart"] != nil
      @opposite_media["La Croix"] = "Médiapart"
    else
      @opposite_media["La Croix"] = "Libération"
    end

    if @hash_source_url["Marianne"] != nil
      @opposite_media["La Tribune"] = "Marianne"
    elsif @hash_source_url["Médiapart"] != nil
      @opposite_media["La Tribune"] = "Médiapart"
    else
      @opposite_media["La Tribune"] = "Libération"
    end

    @opposite_media["Médiapart"] = "Le Point"
    @opposite_media["Valeurs Actuelles"] = "Le Monde"

  end

end
