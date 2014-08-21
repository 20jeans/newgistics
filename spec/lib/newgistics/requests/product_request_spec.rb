require 'spec_helper'

describe Newgistics::ProductRequest do
  it 'renders the request' do
    products = 5.times.map do |i|
      Newgistics::Product.new.tap do |p|
        p.sku = "SKU-#{i.to_s * 4}"
      end
    end
    request = Newgistics::ProductRequest.new(products)
    puts request.render
  end
end