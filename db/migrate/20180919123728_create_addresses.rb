class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.integer :kind
      t.string :street
      t.references :company, foreign_key: true
      t.references :pincode, foreign_key: true

      t.timestamps
    end
  end
end
