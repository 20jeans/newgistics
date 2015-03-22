module Newgistics
  class ProductRequest < Newgistics::Request
    # @return [Array<Newgistics::Product>] an array of Newgistics::Product objects
    attr_accessor :products

    def initialize(products)
      self.products = products
    end

    # @return [Boolean] returns whether the array of products is valid or not
    def valid?
      products.all?(&:valid?)
    end

    # @return [Array<String>] returns an array of error messages if any
    def errors
      products.map{|product| product.errors.full_messages }.flatten
    end
  end
end