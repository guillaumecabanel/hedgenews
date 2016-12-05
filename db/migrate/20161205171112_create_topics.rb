class CreateTopics < ActiveRecord::Migration[5.0]
  def change
    create_table :topics do |t|
      t.string :name
      t.text :presentation
      t.text :most_used_words

      t.timestamps
    end
  end
end
