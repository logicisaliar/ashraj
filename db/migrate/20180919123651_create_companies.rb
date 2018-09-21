class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name
      t.integer :kind
      t.integer :parent_id, optional: true
      t.string :pan_number
      t.string :gst_end
      t.float :days, default: 30
      t.float :balance
      t.float :open_balance, default: 0
      t.string :spl_instructions
      t.float :payment_score

      t.timestamps
    end
  end
end
