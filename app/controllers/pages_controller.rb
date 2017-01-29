class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :team, :about, :styleguide]

  def home
    # @topics = Topic.all.sample(3)
    # @topic_names = []
    # Topic.all.each do |topic|
    #   @topic_names << topic.name
    # end

    hedgy_id = User.find_by_email("hedgy@hedgenews.eu")

    if Topic.count >= 4
      @topics = Topic.where(user_id: hedgy_id).order(:created_at)[-4..-2].reverse
    else
      @topics = Topic.where(user_id: hedgy_id).all
    end

    @main_topic = Topic.where(user_id: hedgy_id).order(:created_at).last

  end

  def styleguide
  end

  def team
  end

  def about
  end

end
