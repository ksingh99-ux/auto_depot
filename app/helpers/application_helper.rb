module ApplicationHelper
  def nav_categories
    Category.order(:name)
  end
end
