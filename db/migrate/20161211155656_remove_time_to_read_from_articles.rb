class RemoveTimeToReadFromArticles < ActiveRecord::Migration[5.0]
  def change
    remove_column :articles, :time_to_read, :string
  end
end
