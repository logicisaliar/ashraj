class CreateTransports < ActiveRecord::Migration[5.2]
  def change
    create_table :transports do |t|
      t.string :name
      t.string :street
      t.string :village
      t.string :number
      t.boolean :courier

      t.timestamps
    end
  end
end
