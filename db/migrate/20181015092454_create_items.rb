class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :quantity
      t.references :product, foreign_key: true
      t.float :discount
      t.float :amount
      t.float :mrp
      t.float :rate
      t.float :gst
      t.float :total
      t.references :packing, foreign_key: true
      t.references :order, foreign_key: true


      t.timestamps
    end
  end
end
