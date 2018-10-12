class CreateHarmonics < ActiveRecord::Migration[5.2]
  def change
    create_table :harmonics do |t|
      t.integer :hsn
      t.text :description

      t.timestamps
    end
  end
end
