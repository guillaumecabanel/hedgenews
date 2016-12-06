class PagesController < ApplicationController
  def home
    api_instance = AylienNewsApi::DefaultApi.new

    opts = {
      :title => 'brexit',
      :published_at_start => "NOW-7DAYS",
      :published_at_end => "NOW",
      :language => ['fr'],
      :source => {:name => ["le monde", "marianne", "libération", "figaro", "les echos"]},
      :return => ["id", "title", "body", "summary", "source", "author", "keywords",
                  "hashtags", "words_count", "categories", "sentiment", "language", "published_at", "links"],
      :sort_by => 'relevance',
      :per_page => 10
    }

    begin
      #List stories
      @result = api_instance.list_stories(opts)
      puts @result
    rescue AylienNewsApi::ApiError => e
      puts "Exception when calling DefaultApi->list_stories: #{e}"
    end

  end

  def styleguide
  end

  def team
  end

  def about
  end

end
