class AddImageUrlToTopics < ActiveRecord::Migration[5.0]
  def change
    add_column :topics, :image_url, :string
  end
end
