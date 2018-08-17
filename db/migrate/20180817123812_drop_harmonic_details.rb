class DropHarmonicDetails < ActiveRecord::Migration[5.2]
  def change
    drop_table :harmonic_details
  end
end
