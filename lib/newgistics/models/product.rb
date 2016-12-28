require 'active_model'
require 'bigdecimal'

# A model to represent a product in newgistics
module Newgistics
  class Product
    include Virtus.model
    include ActiveModel::Validations

    # @return [String] the name of the product
    attribute :name, String
    # @return [String] the sku of the product (required)
    attribute :sku, String
    # @return [String] the sku of the product (required)
    attribute :qty, Integer
    # @return [String] the universal product code of the product
    attribute :upc, String
    # @return [String] the country of origin for the product
    attribute :country, String
    # @return [Float] the price of the product
    attribute :price, BigDecimal
    # @return [String] the harmonization code for customs
    attribute :harmonization_code, String

    validates :sku, presence: true

    def self.from_spree(item)
      self.new({
          name: item.name,
          sku: item.sku,
          qty: item.quantity
        })
    end
  end
end