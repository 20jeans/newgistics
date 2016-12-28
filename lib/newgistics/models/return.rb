require 'active_model'
# A model representing a return for newgistics
module Newgistics
  class Return
    include Virtus.model(mass_assignment: false)
    include ActiveModel::Validations

    # @return [String] the order number for the return (required)
    attribute :number, String
    # @return [Array<Newgistics::Product>] an array of the products for the order (required)
    attribute :line_items, Array[Newgistics::Product]

    validates :number, presence: true
    validates :line_items, presence: true
  end
end