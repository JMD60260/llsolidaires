class AddIdentityFileToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :identity_file, :string
  end
end
