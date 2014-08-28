require 'spec_helper'

describe Newgistics::Client do
  context '#create_product' do
    it 'creates products in newgistics' do
      products = 5.times.map do |i|
        Newgistics::Product.new.tap do |p|
          p.sku = "SKU-#{i.to_s * 4}"
        end
      end
      client = Newgistics::Client.new
      response = client.create_products(products)
      expect(response.products.size).to eq(products.size)
    end
  end

  context '#create_shipment' do
  end

  context '#create_return' do
  end

  context '#list_manifests' do
  end
end