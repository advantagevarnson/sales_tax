# frozen_string_literal: true

require_relative '../../../src/constants'
require_relative '../models/purchase'

module SalesTaxHelper
  def self.tax_totals(rows)
    array = []

    rows.each do |hash|
      quantity, product, price = hash.values
      @purchase = Purchase.new(quantity, product, price)
      next if @purchase.quantity == '0'

      array.push(@purchase.quantity,
                 @purchase.product,
                 (@purchase.purchase_float + @purchase.total_taxable_amount).round(2),
                 (@purchase.total_taxable_amount).round(2))
    end
    array
  end
end
