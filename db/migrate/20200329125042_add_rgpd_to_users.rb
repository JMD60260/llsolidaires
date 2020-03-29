class AddRgpdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :rgpd, :boolean
  end
end
