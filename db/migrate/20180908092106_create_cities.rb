class CreateCities < ActiveRecord::Migration[5.2]
  def change
    create_table :cities do |t|
      t.string :name
      t.references :state, foreign_key: true
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
