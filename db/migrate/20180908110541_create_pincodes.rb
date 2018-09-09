class CreatePincodes < ActiveRecord::Migration[5.2]
  def change
    create_table :pincodes do |t|
      t.integer :pin
      t.references :city, foreign_key: true

      t.timestamps
    end
  end
end
