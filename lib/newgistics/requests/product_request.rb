module Newgistics
  class ProductRequest < Newgistics::Request
    attr_accessor :products

    def initialize(products)
      self.products = products
    end

    def valid?
      products.all?(&:valid?)
    end

    def errors
      products.map{|product| product.errors.full_messages }
    end
  end
end