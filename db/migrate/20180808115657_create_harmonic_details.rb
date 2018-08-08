class CreateHarmonicDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :harmonic_details do |t|
      t.integer :hsn_chapter
      t.float :gst
      t.string :description

      t.timestamps
    end
  end
end
