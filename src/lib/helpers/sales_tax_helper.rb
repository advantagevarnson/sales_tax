# frozen_string_literal: true

require_relative '../../../src/constants'
require_relative '../models/purchase'

module SalesTaxHelper
  def self.calculate_tax(rows)
    final_array = []

    rows.each do |hash|
      quantity, product, price = hash.values

      @purchase = Purchase.new(quantity, product, price)
      @purchase.price = @purchase.price * quantity.to_i
      next if @purchase.quantity == "0"
      purchase_float = @purchase.price.to_f
      if @purchase.product.split(' ').map(&:strip).any? { |word| ELIGIBLE_IMPORT_DUTY.include?(word) }
        import_tax = ((purchase_float * 0.05) * 20).ceil / 20.0
      end

      unless @purchase.product.split(' ').map(&:strip).any? { |word| EXEMPT_SALES_TAX.include?(word) }
        sales_tax = ((purchase_float * 0.10) * 20).ceil / 20.0
      end

      import_tax.nil? ? import_tax = 0 : import_tax
      sales_tax.nil? ? sales_tax = 0 : sales_tax

      final_array.push(@purchase.quantity,
                       @purchase.product,
                       (purchase_float + import_tax + sales_tax).round(2),
                       (import_tax + sales_tax).round(2))
    end

    final_array
  end
end
