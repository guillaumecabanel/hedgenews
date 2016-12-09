class AddLogosToTopics < ActiveRecord::Migration[5.0]
  def change
    add_column :topics, :logos, :string
  end
end
