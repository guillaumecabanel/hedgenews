class PagesController < ApplicationController
  def home
    # @topics = Topic.all.sample(3)
    # @topic_names = []
    # Topic.all.each do |topic|
    #   @topic_names << topic.name
    # end

    @topics = Topic.all[-4..-2]
    @main_topic = Topic.last
  end

  def styleguide
  end

  def team
  end

  def about
  end

end
