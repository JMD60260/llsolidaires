class AddLatitudeFromFlats < ActiveRecord::Migration[6.0]
  def change
    add_column :flats, :latitude, :float
  end
end
