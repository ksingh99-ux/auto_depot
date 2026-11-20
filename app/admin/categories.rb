ActiveAdmin.register Category do
  permit_params :name, :description

  index do
    selectable_column
    id_column
    column :name
    column :description
    column "Products" do |category|
      category.products.count
    end
    actions
  end

  filter :name

  show do
    attributes_table do
      row :name
      row :description
    end

    panel "Products in this category" do
      table_for category.products do
        column :name
        column :price
      end
    end
  end

  form do |f|
    f.semantic_errors
    f.inputs "Category Details" do
      f.input :name
      f.input :description
    end
    f.actions
  end
end
