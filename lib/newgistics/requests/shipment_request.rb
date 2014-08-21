module Newgistics
  class ShipmentRequest < Newgistics::Request
    attr_accessor :shipment

    def initialize(shipment)
      self.shipment = shipment
    end
  end
end