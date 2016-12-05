class CreateJournalists < ActiveRecord::Migration[5.0]
  def change
    create_table :journalists do |t|
      t.string :first_name
      t.string :last_name
      t.text :presentation

      t.timestamps
    end
  end
end
