class Purchase
  attr_accessor :quantity, :product, :price

  def initialize(quantity, product, price)
    @quantity = quantity
    @product = product
    @price = price
  end

  def purchase_price
    price * quantity.to_i
  end

  def purchase_float
    price.to_f
  end

  def import_percentage
    0.05
  end

  def standard_tax_percentage
    0.10
  end

  def sanitized
    product.split(' ').map(&:strip)
  end

  def import_tax
    sanitized.any? { |word| ELIGIBLE_IMPORT_DUTY.include?(word) } ? import_percentage : 0
  end

  def standard_tax
    sanitized.any? { |word| EXEMPT_SALES_TAX.include?(word) } ? 0 : standard_tax_percentage
  end

  def tax_amount(type)
    ((purchase_float * eval("#{type}")) * 20).ceil / 20.0
  end

  def total_taxable_amount
    tax_amount("import_tax") + tax_amount("standard_tax")
  end
end
