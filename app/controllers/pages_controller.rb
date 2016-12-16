class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :team, :about, :styleguide]

  def home
    # @topics = Topic.all.sample(3)
    # @topic_names = []
    # Topic.all.each do |topic|
    #   @topic_names << topic.name
    # end

    if Topic.count >= 4
      @topics = Topic.order(:created_at)[-4..-2].reverse
    else
      @topics = Topic.all
    end

    @main_topic = Topic.order(:created_at).last

  end

  def styleguide
  end

  def team
  end

  def about
  end

end
