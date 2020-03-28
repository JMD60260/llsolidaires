class AddProofToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :proof, :string
  end
end
