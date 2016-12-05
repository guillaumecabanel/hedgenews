class CreateSources < ActiveRecord::Migration[5.0]
  def change
    create_table :sources do |t|
      t.string :name
      t.text :presentation
      t.string :logo_url
      t.string :orientation

      t.timestamps
    end
  end
end
