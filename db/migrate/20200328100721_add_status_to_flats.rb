class AddStatusToFlats < ActiveRecord::Migration[6.0]
  def change
    add_column :flats, :status, :string, :default => "libre"
  end
end
