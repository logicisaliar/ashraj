class CreatePackings < ActiveRecord::Migration[5.2]
  def change
    create_table :packings do |t|
      t.float :rebate
      t.float :pack_size
      t.boolean :sample

      t.timestamps
    end
  end
end
