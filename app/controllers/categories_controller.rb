class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @products = @category.products.order(:name).page(params[:page]).per(8)
  end
end
