# frozen_string_literal: true

require 'csv'

module CSVHelper
  def self.ingest_csv(csv_path)
    rows = []
    table = CSV.parse(File.read(csv_path), headers: true)

    table.each do |row|
      rows << row.to_h
    end
    rows
  end

  def self.output_data(array)
    sales_tax_total = 0
    total = 0
    csv_string = CSV.generate do |csv|
      line_items = array.each_slice(4).to_a
      line_items.each do |line|
        sales_tax_total += line[3]
        line.pop
        total += line[2]
        csv << line
      end

      csv << ["Sales Taxes: #{sprintf('%.2f', sales_tax_total)}"]
      csv << ["Total: #{total.round(2)}"]
    end
    csv_string
  end
end

