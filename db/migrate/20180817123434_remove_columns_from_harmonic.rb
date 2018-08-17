class RemoveColumnsFromHarmonic < ActiveRecord::Migration[5.2]
  def change
    remove_column :harmonics, :hsn_end, :integer
    remove_column :harmonics, :gst, :float
    remove_reference :harmonics, :harmonic_detail, foreign_key: true
  end
end
