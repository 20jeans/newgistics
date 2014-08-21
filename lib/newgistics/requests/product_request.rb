module Newgistics
  class ProductRequest < Newgistics::Request
    attr_accessor :products

    def initialize(products)
      self.products = products
    end
  end
end