ActiveAdmin.register Page do
  permit_params :title, :content
  actions :all, except: %i[new destroy]

  index do
    column :title
    column :slug
    column :updated_at
    actions
  end

  filter :title

  show do
    attributes_table do
      row :title
      row :slug
      row :content do |page|
        simple_format(page.content)
      end
      row :updated_at
    end
  end

  form do |f|
    f.semantic_errors
    f.inputs "Page Content" do
      f.input :title
      f.input :content, as: :text, input_html: { rows: 14 }
    end
    f.actions
  end
end
