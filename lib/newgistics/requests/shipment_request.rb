module Newgistics
  module Requests
    class ShipmentRequest < Matey::Request
      attr_accessor :shipment

      def initialize(shipment)
        self.shipment = shipment
      end
    end
  end
end