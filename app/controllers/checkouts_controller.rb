class CheckoutsController < ApplicationController
  before_action :authenticate_customer!
  before_action :require_cart_items

  # Step 1: customer confirms or enters their address and province
  def address
    @customer = current_customer
  end

  def update_address
    @customer = current_customer
    @customer.assign_attributes(address_params)

    if @customer.save(context: :checkout)
      redirect_to checkout_review_path
    else
      render :address, status: :unprocessable_entity
    end
  end

  # Step 2: invoice with taxes based on the customer's province
  def review
    return redirect_to(checkout_path, alert: "Please enter your address first.") unless address_complete?

    @customer = current_customer
    @totals = CartTotals.new(session[:cart], current_customer.province)
  end

  # Step 3: save the order and its items
  def create
    return redirect_to(checkout_path, alert: "Please enter your address first.") unless address_complete?

    order = build_order(CartTotals.new(session[:cart], current_customer.province))

    if order.save
      session.delete(:cart)
      redirect_to order_path(order), notice: "Thank you! Your order has been placed."
    else
      redirect_to checkout_review_path, alert: "Sorry, your order could not be placed."
    end
  end

  private

  def require_cart_items
    redirect_to cart_path, alert: "Your cart is empty." if session[:cart].blank?
  end

  def address_complete?
    customer = current_customer
    customer.address.present? && customer.city.present? &&
      customer.postal_code.present? && customer.province.present?
  end

  def address_params
    params.require(:customer).permit(:address, :city, :postal_code, :province_id)
  end

  def build_order(totals)
    customer = current_customer
    province = customer.province

    order = customer.orders.new(
      status: "new",
      address: customer.address,
      city: customer.city,
      postal_code: customer.postal_code,
      province_name: province.name,
      gst_rate: province.gst_rate,
      pst_rate: province.pst_rate,
      hst_rate: province.hst_rate,
      subtotal: totals.subtotal,
      gst_amount: totals.gst,
      pst_amount: totals.pst,
      hst_amount: totals.hst,
      total: totals.total
    )

    # Copy the price at the time of purchase into each order item
    totals.items.each do |item|
      order.order_items.build(product: item[:product], quantity: item[:quantity], unit_price: item[:product].price)
    end

    order
  end
end
