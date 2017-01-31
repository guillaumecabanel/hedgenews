module ArticlesHelper
  def time_to_read(words_count)
    time = words_count / 250
    if time < 1
      return "Moins d'une minute à lire"
    elsif time < 2
      return "Une minute à lire"
    else
      return "#{time} minutes à lire"
    end
  end

  # had to put that method in the articles controller
  def story_opposite_url(story, source_urls)
    source_name = Source.where(aylien_id: story.source.id.to_i).first.name

    opposite_media = Article::OPPOSITE_MEDIA[source_name]
    return unless opposite_media

    opposite_media.each do |opposite_medium|
      opposite_url = source_urls[opposite_medium]
      return opposite_url if opposite_url
    end

    return nil
  end

end
