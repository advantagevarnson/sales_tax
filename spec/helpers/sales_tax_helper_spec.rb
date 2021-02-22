# frozen_string_literal: true

require 'spec_helper'
require_relative '../../src/lib/helpers/sales_tax_helper'

describe SalesTaxHelper do

  describe '#calculate_tax' do
    let(:calculate_tax) { described_class.calculate_tax(rows) }
    let(:rows) do
      [
        {"Quantity"=>"1",
         " Product"=>" book",
         " Price"=>" 12.49"},
        {"Quantity"=>"1",
         " Product"=>" music cd",
         " Price"=>" 14.99"},
        {"Quantity"=>"1",
         " Product"=>" chocolate bar",
         " Price"=>" 0.85"}
      ]
    end
    let(:expected_output) do
      ["1", " book", 12.49, 0, "1", " music cd", 16.49, 1.5, "1", " chocolate bar", 0.85, 0]
    end

    context 'with quantities larger than 0' do
      it 'will calculate the tax for all rows' do
        expect(calculate_tax).to eq(expected_output)
      end

      it 'will return the same number of rows given' do
        expect(calculate_tax.each_slice(4).to_a.length).to eq(rows.length)
      end
    end

    context 'with a quantity lower than 0' do
      let(:rows) do
        [
          {"Quantity"=>"0",
           " Product"=>" book",
           " Price"=>" 12.49"},
          {"Quantity"=>"1",
           " Product"=>" music cd",
           " Price"=>" 14.99"},
          {"Quantity"=>"1",
           " Product"=>" chocolate bar",
           " Price"=>" 0.85"}
        ]
      end
      let(:expected_output) do
        ["1", " music cd", 16.49, 1.5, "1", " chocolate bar", 0.85, 0]
      end

      it 'will calculate the tax for all rows except the 0 quantity row' do
        expect(calculate_tax).to eq(expected_output)
      end

      it 'will return the correct number of rows' do
        expect(calculate_tax.each_slice(4).to_a.length).to eq(rows.length - 1)
      end
    end
  end
end
