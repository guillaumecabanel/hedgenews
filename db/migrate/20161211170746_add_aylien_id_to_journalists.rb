class AddAylienIdToJournalists < ActiveRecord::Migration[5.0]
  def change
    add_column :journalists, :aylien_id, :integer
  end
end
