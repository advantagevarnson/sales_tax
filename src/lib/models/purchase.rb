class Purchase
  attr_accessor :quantity, :product, :price

  def initialize(quantity, product, price)
    @quantity = quantity
    @product = product
    @price = price
  end
end
