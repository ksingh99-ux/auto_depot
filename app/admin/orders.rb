ActiveAdmin.register Order do
  actions :index, :show

  index do
    id_column
    column :customer
    column :status
    column :province_name
    column :total do |order|
      number_to_currency(order.total)
    end
    column :created_at
    actions
  end

  filter :status
  filter :created_at

  show do
    attributes_table do
      row :customer
      row :status
      row :address
      row :city
      row :postal_code
      row :province_name
      row :subtotal
      row :gst_amount
      row :pst_amount
      row :hst_amount
      row :total
    end

    panel "Products in this order" do
      table_for order.order_items do
        column :product
        column :quantity
        column :unit_price
      end
    end
  end
end
