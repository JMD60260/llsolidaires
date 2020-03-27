class RemoveFieldLatitueFromFlats < ActiveRecord::Migration[6.0]
  def change

    remove_column :flats, :latitue, :float
  end
end
