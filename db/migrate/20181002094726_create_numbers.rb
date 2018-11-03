class CreateNumbers < ActiveRecord::Migration[5.2]
  def change
    create_table :numbers do |t|
      t.string :num
      t.integer :primary
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
