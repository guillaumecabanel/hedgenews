class AddAylienIdToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :aylien_id, :integer
  end
end