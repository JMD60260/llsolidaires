class AddValidationToRentals < ActiveRecord::Migration[6.0]
  def change
    add_column :rentals, :validated, :boolean, default: false
  end
end
