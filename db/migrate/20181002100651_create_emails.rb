class CreateEmails < ActiveRecord::Migration[5.2]
  def change
    create_table :emails do |t|
      t.string :eadd
      t.integer :primary
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
