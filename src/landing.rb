# frozen_string_literal: true

require_relative 'lib/models/purchase'
require_relative 'lib/helpers/csv_helper'
require_relative 'lib/helpers/sales_tax_helper'

puts 'Please select 1, 2 or 3 based on which input file you would like to use:'
response = STDIN.gets.chomp

case response
when '1'
  rows = CSVHelper.ingest_csv('src/inputs/input1.csv')
  array = SalesTaxHelper.tax_totals(rows)
  puts CSVHelper.output_data(array)
when '2'
  rows = CSVHelper.ingest_csv("src/inputs/input2.csv")
  array = SalesTaxHelper.tax_totals(rows)
  puts CSVHelper.output_data(array)
when '3'
  rows = CSVHelper.ingest_csv('src/inputs/input3.csv')
  array = SalesTaxHelper.tax_totals(rows)
  puts CSVHelper.output_data(array)
else
  puts 'You have selected incorrectly, goodbye.'
  exit
end
