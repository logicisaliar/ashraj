class CreateHarmonics < ActiveRecord::Migration[5.2]
  def change
    create_table :harmonics do |t|
      t.integer :hsn_end
      t.references :harmonic_detail, foreign_key: true

      t.timestamps
    end
  end
end
