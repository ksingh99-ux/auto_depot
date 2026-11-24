# Works out the invoice for the cart: subtotal and taxes based on the province
class CartTotals
  attr_reader :items, :province

  def initialize(cart, province)
    cart ||= {}
    products = Product.where(id: cart.keys).order(:name)
    @items = products.map { |product| { product: product, quantity: cart[product.id.to_s].to_i } }
    @province = province
  end

  def subtotal
    items.sum { |item| item[:product].price * item[:quantity] }
  end

  def gst
    (subtotal * province.gst_rate).round(2)
  end

  def pst
    (subtotal * province.pst_rate).round(2)
  end

  def hst
    (subtotal * province.hst_rate).round(2)
  end

  def total
    subtotal + gst + pst + hst
  end
end
