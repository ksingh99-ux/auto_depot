class CartItemsController < ApplicationController
  def create
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i
    quantity = 1 if quantity < 1

    cart = session[:cart] || {}
    cart[product.id.to_s] = cart[product.id.to_s].to_i + quantity
    session[:cart] = cart

    redirect_to cart_path, notice: "#{product.name} was added to your cart."
  end
end
