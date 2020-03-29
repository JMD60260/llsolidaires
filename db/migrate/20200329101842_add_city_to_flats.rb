class AddCityToFlats < ActiveRecord::Migration[6.0]
  def change
    add_column :flats, :city, :string
  end
end
