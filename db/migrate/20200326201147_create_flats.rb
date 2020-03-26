class CreateFlats < ActiveRecord::Migration[6.0]
  def change
    create_table :flats do |t|
      t.string :address
      t.string :flat_type
      t.text :description
      t.boolean :accessibility_pmr
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
