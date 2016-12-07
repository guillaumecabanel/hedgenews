module ArticleHelper
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
end
