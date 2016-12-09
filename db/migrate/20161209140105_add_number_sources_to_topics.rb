class AddNumberSourcesToTopics < ActiveRecord::Migration[5.0]
  def change
    add_column :topics, :number_sources, :string
  end
end
