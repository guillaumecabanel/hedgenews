class AddNameToCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :name, :string
  end
end
