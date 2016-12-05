class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.date :date
      t.text :abstract
      t.text :full_text
      t.string :pic_url
      t.text :quoted_links
      t.integer :words_count
      t.integer :time_to_read
      t.text :unique_words
      t.string :source_url
      t.references :source, foreign_key: true
      t.references :category, foreign_key: true
      t.references :journalist, foreign_key: true

      t.timestamps
    end
  end
end
