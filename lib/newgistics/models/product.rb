module Newgistics
  class Product
    include Virtus.model(mass_assignment: false)

    attribute :name, String
    attribute :sku, String

    validates :name, presence: true
    validates :sku, presence: true
  end
end