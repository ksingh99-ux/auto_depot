class AddDetailsToCustomers < ActiveRecord::Migration[7.2]
  def change
    add_column :customers, :first_name, :string
    add_column :customers, :last_name, :string
    add_column :customers, :address, :string
    add_column :customers, :city, :string
    add_column :customers, :postal_code, :string
    add_reference :customers, :province, null: false, foreign_key: true
  end
end
