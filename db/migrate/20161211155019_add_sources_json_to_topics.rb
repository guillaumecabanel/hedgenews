class AddSourcesJsonToTopics < ActiveRecord::Migration[5.0]
  def change
    add_column :topics, :sources_json, :text
  end
end
