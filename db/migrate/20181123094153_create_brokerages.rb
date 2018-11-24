class CreateBrokerages < ActiveRecord::Migration[5.2]
  def change
    create_table :brokerages do |t|
      t.references :order, foreign_key: true
      t.float :tds
      t.float :commission
      t.float :amount
      t.text :narration
      t.date :brokerage_date

      t.timestamps
    end
  end
end
