module Newgistics
  class ShipmentRequest < Newgistics::Request
    # @return [Newgistics::Shipment] a model representing the shipment
    attr_accessor :shipment

    DEFAULTS = {}

    def headers
      {
        'User-Agent' => 'Fiddler',
        "Content-type" => "application/json; charset=utf-8",
      }
    end

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

  class OrderShipmentRequest < Newgistics::Request
    # @return [Newgistics::Shipment] a model representing the shipment
    attr_accessor :shipment

    DEFAULTS = {}

    def headers
      {
        'User-Agent' => 'Fiddler',
        "Content-type" => "application/json; charset=utf-8",
      }
    end

    def initialize(order, shipment)
      self.shipment = shipment
      self.order = order
    end

    # @return [Boolean] returns whether the shipment and ship address are valid
    def valid?
      order.valid? and shipment.valid? and shipment.ship_address.valid?
    end

    # @return [Array<String>] returns the errors for the shipment and ship address if any
    def errors
      order.errors.full_messages + shipment.errors.full_messages + shipment.ship_address.errors.full_messages
    end
  end
end