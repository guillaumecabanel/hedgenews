class AddHashtagsToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :hashtags, :string
  end
end
