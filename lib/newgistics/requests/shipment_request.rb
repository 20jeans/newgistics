module Newgistics
  class ShipmentRequest < Newgistics::Request
    attr_accessor :shipment

    def initialize(shipment)
      self.shipment = Shipment.new(shipment)
    end

    def valid?
      shipment.valid? && shipment.ship_address.valid?
    end

    def errors
      shipment.errors.full_messages + shipment.ship_address.errors.full_messages
    end
  end
end