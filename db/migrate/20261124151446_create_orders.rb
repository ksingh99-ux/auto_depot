class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :status
      t.string :address
      t.string :city
      t.string :postal_code
      t.string :province_name
      t.decimal :gst_rate, precision: 6, scale: 5
      t.decimal :pst_rate, precision: 6, scale: 5
      t.decimal :hst_rate, precision: 6, scale: 5
      t.decimal :subtotal, precision: 10, scale: 2
      t.decimal :gst_amount, precision: 10, scale: 2
      t.decimal :pst_amount, precision: 10, scale: 2
      t.decimal :hst_amount, precision: 10, scale: 2
      t.decimal :total, precision: 10, scale: 2

      t.timestamps
    end
  end
end
