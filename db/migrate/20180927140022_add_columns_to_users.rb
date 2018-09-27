class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :company, foreign_key: true
    add_column :users, :first_name, :string
    add_column :users, :dept, :integer
    add_column :users, :dob, :date
  end
end
