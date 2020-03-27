class ChangeStatusFlat < ActiveRecord::Migration[6.0]
  def change
    change_column :flats, :flat_type, 'integer USING CAST(flat_type AS integer)'
  end
end
