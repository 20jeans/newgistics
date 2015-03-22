# A model representing a shipment in newgistics
module Newgistics
  class Shipment
    include Virtus.model(mass_assignment: false)
    include ActiveModel::Validations

    # @return [String] the id of the shipment (required)
    attribute :number, String
    # @return [String] the email of the purchaser
    attribute :email, String
    # @return [DateTime] the time the order was placed (required)
    attribute :completed_at, DateTime
    # @return [Newgistics::Address] the address the order was shipped to
    attribute :ship_address, Newgistics::Address
    # @return [String] the method used to ship the order
    attribute :ship_method, String
    # @return [Array<Newgistics::Product>] an array of products in the order (required)
    attribute :line_items, Array[Newgistics::Product]
    # @return [Hash] additional options for the model
    attribute :options, Hash, default: {}

    validates :number, presence: true
    validates :completed_at, presence: true
    validates :line_items, presence: true
  end
end