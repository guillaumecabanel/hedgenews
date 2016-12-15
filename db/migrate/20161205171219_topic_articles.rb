class TopicArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :topic_articles do |t|
      t.references :topic, foreign_key: true
      t.references :article, foreign_key: true
      t.timestamps
    end
  end
end
