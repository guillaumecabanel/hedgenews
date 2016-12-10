class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :team, :about, :styleguide]

  def home
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
