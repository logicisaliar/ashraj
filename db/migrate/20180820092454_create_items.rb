class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.float :quantity
      t.references :product, foreign_key: true
      t.float :discount
      t.references :packing, foreign_key: true
      t.float :amount
      t.float :price

      t.timestamps
    end
  end
end
