class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :company, foreign_key: true
      t.references :item, foreign_key: true
      t.references :transport, foreign_key: true
      t.integer :status
      t.datetime :complete_date
      t.datetime :confirmation_date
      t.datetime :packed_date
      t.datetime :invoice_date
      t.datetime :dispatch_date
      t.datetime :release_date
      t.integer :invoice_numer
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
