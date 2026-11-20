class ProductsController < ApplicationController
  def index
    @products = Product.includes(:category).order("categories.name", :name).references(:category)
  end

  def show
    @product = Product.find(params[:id])
  end
end
