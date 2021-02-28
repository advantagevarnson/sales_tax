# frozen_string_literal: true

require_relative 'lib/models/purchase'
require_relative 'lib/helpers/csv_helper'
require_relative 'lib/helpers/sales_tax_helper'

puts 'Please select 1, 2 or 3 based on which input file you would like to use:'
response = STDIN.gets.chomp

case response
when '1', '2', '3'
  rows = CSVHelper.ingest_csv("src/inputs/input#{response}.csv")
  array = SalesTaxHelper.tax_totals(rows)
  puts CSVHelper.output_data(array)
else
  puts 'You have selected incorrectly, goodbye.'
  exit
end
