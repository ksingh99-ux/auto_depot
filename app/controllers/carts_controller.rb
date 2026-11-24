class CartsController < ApplicationController
  def show
    cart = session[:cart] || {}
    products = Product.includes(:category).where(id: cart.keys).order(:name)

    @cart_items = products.map { |product| { product: product, quantity: cart[product.id.to_s].to_i } }
    @subtotal = @cart_items.sum { |item| item[:product].price * item[:quantity] }
  end
end
