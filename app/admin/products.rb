ActiveAdmin.register Product do
  permit_params :category_id, :name, :description, :price, :stock_quantity, :on_sale, :image

  index do
    selectable_column
    id_column
    column :image do |product|
      image_tag(product.image, width: 50) if product.image.attached?
    end
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

  show do
    attributes_table do
      row :image do |product|
        image_tag(product.image, width: 250) if product.image.attached?
      end
      row :name
      row :category
      row :description
      row :price do |product|
        number_to_currency(product.price)
      end
      row :stock_quantity
      row :on_sale
      row :created_at
      row :updated_at
    end
  end

  form html: { multipart: true } do |f|
    f.semantic_errors
    f.inputs "Product Details" do
      f.input :category, as: :select, collection: Category.order(:name)
      f.input :name
      f.input :description
      f.input :price
      f.input :stock_quantity
      f.input :on_sale
      f.input :image, as: :file,
                      hint: (f.object.image.attached? ? image_tag(f.object.image, width: 150) : "No image uploaded yet")
    end
    f.actions
  end
end
