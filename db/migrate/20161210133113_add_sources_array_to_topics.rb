class AddSourcesArrayToTopics < ActiveRecord::Migration[5.0]
  def change
    add_column :topics, :sources_array, :string
  end
end
