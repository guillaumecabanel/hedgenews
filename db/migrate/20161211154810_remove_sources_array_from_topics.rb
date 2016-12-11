class RemoveSourcesArrayFromTopics < ActiveRecord::Migration[5.0]
  def change
    remove_column :topics, :sources_array, :string
  end
end
