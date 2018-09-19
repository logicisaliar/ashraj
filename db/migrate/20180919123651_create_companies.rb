class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name
      t.integer :kind
      t.integer :parent_id
      t.text :pan_number
      t.text :gst_end
      t.float :days
      t.float :balance
      t.float :open_balance
      t.string :spl_instructions
      t.float :payment_score

      t.timestamps
    end
  end
end
