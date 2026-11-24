ActiveAdmin.register Customer do
  permit_params :first_name, :last_name, :email, :address, :city, :postal_code, :province_id

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :email
    column :city
    column :province
    column :created_at
    actions
  end

  filter :first_name
  filter :last_name
  filter :email
  filter :province

  show do
    attributes_table do
      row :first_name
      row :last_name
      row :email
      row :address
      row :city
      row :postal_code
      row :province
      row :created_at
    end
  end

  form do |f|
    f.semantic_errors
    f.inputs "Customer Details" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :address
      f.input :city
      f.input :postal_code
      f.input :province, as: :select, collection: Province.order(:name)
    end
    f.actions
  end
end
