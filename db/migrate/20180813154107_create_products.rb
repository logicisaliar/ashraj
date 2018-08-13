class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.float :discount
      t.text :description
      t.references :type, foreign_key: true
      t.float :mrp
      t.string :unit
      t.references :harmonic, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
