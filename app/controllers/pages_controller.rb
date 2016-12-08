class PagesController < ApplicationController
  def home
    @topics = Topic.all.sample(3)
  end

  def styleguide
  end

  def team
  end

  def about
  end

end
