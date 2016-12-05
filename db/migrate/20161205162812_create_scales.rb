class CreateScales < ActiveRecord::Migration[5.0]
  def change
    create_table :scales do |t|
      t.integer :value
      t.references :source, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
