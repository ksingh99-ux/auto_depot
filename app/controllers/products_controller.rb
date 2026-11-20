class ProductsController < ApplicationController
  def index
    @filter = params[:filter]

    @products = Product.includes(:category).references(:category).order("categories.name", :name)
    @products = @products.where(on_sale: true) if @filter == "on_sale"
    @products = @products.where("products.created_at >= ?", 3.days.ago) if @filter == "new"
    @products = @products.page(params[:page]).per(8)
  end

  def show
    @product = Product.find(params[:id])
  end
end
