module ApplicationHelper
  def nav_categories
    Category.order(:name)
  end

  def cart_count
    (session[:cart] || {}).values.sum(&:to_i)
  end
end
