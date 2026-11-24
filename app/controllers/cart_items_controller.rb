class CartItemsController < ApplicationController
  # Add a product to the cart (3.1.1)
  def create
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i
    quantity = 1 if quantity < 1

    cart = session[:cart] || {}
    cart[product.id.to_s] = cart[product.id.to_s].to_i + quantity
    session[:cart] = cart

    redirect_to cart_path, notice: "#{product.name} was added to your cart."
  end

  # Change the quantity of a product in the cart (3.1.2)
  def update
    product = Product.find(params[:id])
    quantity = params[:quantity].to_i

    if quantity < 1
      redirect_to cart_path, alert: "Quantity must be at least 1. Use Remove to take an item out."
      return
    end

    cart = session[:cart] || {}
    cart[product.id.to_s] = quantity
    session[:cart] = cart

    redirect_to cart_path, notice: "Quantity for #{product.name} updated to #{quantity}."
  end

  # Remove a product from the cart (3.1.2)
  def destroy
    product = Product.find(params[:id])

    cart = session[:cart] || {}
    cart.delete(product.id.to_s)
    session[:cart] = cart

    redirect_to cart_path, notice: "#{product.name} was removed from your cart."
  end
end
