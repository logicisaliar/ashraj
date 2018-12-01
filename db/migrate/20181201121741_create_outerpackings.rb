class CreateOuterpackings < ActiveRecord::Migration[5.2]
  def change
    create_table :outerpackings do |t|
      t.references :order, foreign_key: true
      t.references :outer, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
