# frozen_string_literal: true

require 'spec_helper'
require 'csv'
require_relative '../../src/lib/helpers/csv_helper'

describe CSVHelper do
  let(:expected_output) do
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

  describe '#ingest_csv' do
    let(:csv_path) { "src/test_inputs/happypath.csv" }
    let(:csv_ingest) { described_class.ingest_csv(csv_path) }

    context 'with valid csv' do
      it 'will ingest the csv' do
        expect(csv_ingest).to eq(expected_output)
      end
    end
  end
end
