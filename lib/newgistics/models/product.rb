require 'bigdecimal'

# A model to represent a product in newgistics
module Newgistics
  class Product
    include Virtus.model(mass_assignment: false)
    include ActiveModel::Validations

    # @return [String] the name of the product
    attribute :name, String
    # @return [String] the sku of the product (required)
    attribute :sku, String
    # @return [String] the universal product code of the product
    attribute :upc, String
    # @return [String] the country of origin for the product
    attribute :country, String
    # @return [Float] the price of the product
    attribute :price, BigDecimal
    # @return [String] the harmonization code for customs
    attribute :harmonization_code, String

    validates :sku, presence: true
  end
end