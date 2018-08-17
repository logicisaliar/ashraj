class AddColumnsToHarmonic < ActiveRecord::Migration[5.2]
  def change
    add_column :harmonics, :hsn, :integer
    add_column :harmonics, :gst, :float
    add_column :harmonics, :description, :text
  end
end
