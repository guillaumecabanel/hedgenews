class AylienTestsController < ApplicationController

  def search
  end

  def results
    @topic = params[:topic]
    @stories = Aylien.new(topic: @topic).stories
  end
end
