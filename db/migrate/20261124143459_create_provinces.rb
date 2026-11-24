class CreateProvinces < ActiveRecord::Migration[7.2]
  def change
    create_table :provinces do |t|
      t.string :name
      t.string :abbreviation
      t.decimal :gst_rate, precision: 6, scale: 5
      t.decimal :pst_rate, precision: 6, scale: 5
      t.decimal :hst_rate, precision: 6, scale: 5

      t.timestamps
    end
  end
end
