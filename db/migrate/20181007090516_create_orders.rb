class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :company, foreign_key: true
      t.references :transport, foreign_key: true
      t.integer :status, default: "pending"
      t.date :completed_date
      t.date :confirmed_date
      t.date :packed_date
      t.date :invoiced_date
      t.date :dispatched_date
      t.date :released_date
      t.integer :invoice_number
      t.float :invoice_amount
      t.float :invoice_subtotal
      t.float :quantity_kg
      t.float :quantity_l
      t.string :lr
      t.float :freight
      t.float :courier_charge
      t.float :igst
      t.float :cgst
      t.float :sgst
      t.string :remark
      t.references :user, foreign_key: true
      t.string :lr_photo
      t.string :salesperson
      t.float :other_taxes
      t.float :misc_charges
      t.references :address, foreign_key: true
      t.float :sample_kg
      t.float :sample_l
      t.integer :order_num

      t.timestamps
    end
  end
end
