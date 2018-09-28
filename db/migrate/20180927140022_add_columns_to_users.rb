class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :company, foreign_key: true
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :photo, :string
    add_column :users, :role, :integer
    add_column :users, :dob, :date
    add_column :users, :aadhar, :integer
  end
end
