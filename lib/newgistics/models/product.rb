module Newgistics
  class Product
    include Virtus.model(mass_assignment: false)
    include ActiveModel::Validations

    attribute :name, String
    attribute :sku, String
    attribute :upc, String
    attribute :country, String
    attribute :price, String

    validates :sku, presence: true
  end
end