class AddFromcsvToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :from_csv, :boolean, default: false
  end
end
