class RemoveLogosFromTopics < ActiveRecord::Migration[5.0]
  def change
    remove_column :topics, :logos, :string
  end
end
