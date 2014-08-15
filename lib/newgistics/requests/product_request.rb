module Newgistics
  module Requests
    class ProductRequest < Matey::Request
      attr_accessor :products

      def initialize(products)
        self.products = products
      end
    end
  end
end