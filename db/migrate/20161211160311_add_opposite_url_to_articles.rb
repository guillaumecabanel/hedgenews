class AddOppositeUrlToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :opposite_url, :string
  end
end
