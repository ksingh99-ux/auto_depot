ActiveAdmin.register Product do
  permit_params :category_id, :name, :description, :price, :stock_quantity, :on_sale

  index do
    selectable_column
    id_column
    column :name
    column :category
    column :price do |product|
      number_to_currency(product.price)
    end
    column :stock_quantity
    column :on_sale
    actions
  end

  filter :name
  filter :category
  filter :price
  filter :on_sale

  form do |f|
    f.semantic_errors
    f.inputs "Product Details" do
      f.input :category, as: :select, collection: Category.order(:name)
      f.input :name
      f.input :description
      f.input :price
      f.input :stock_quantity
      f.input :on_sale
    end
    f.actions
  end
end
