module Newgistics
  class ShipmentRequest < Newgistics::Request
    # @return [Newgistics::Shipment] a model representing the shipment
    attr_accessor :shipment

    def initialize(shipment)
      self.shipment = shipment
    end

    # @return [Boolean] returns whether the shipment and ship address are valid
    def valid?
      shipment.valid? && shipment.ship_address.valid?
    end

    # @return [Array<String>] returns the errors for the shipment and ship address if any
    def errors
      shipment.errors.full_messages + shipment.ship_address.errors.full_messages
    end
  end
end