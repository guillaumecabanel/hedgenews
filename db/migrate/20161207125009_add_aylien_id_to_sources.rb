class AddAylienIdToSources < ActiveRecord::Migration[5.0]
  def change
    add_column :sources, :aylien_id, :integer
  end
end
