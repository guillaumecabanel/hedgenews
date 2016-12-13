class HedgyGetTopicsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts "Hedgy is going to get topics..."
    # Topic.get
    puts "Hedgy: 'I'm done!'"
  end
end
