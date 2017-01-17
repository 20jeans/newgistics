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

    def initialize(order, shipment)
      addr = order.shipping_address
      @shipment = Shipment.new(
        number: "#{order.number} - #{shipment.id}",
        email:  order.email,
        completed_at: order.completed_at,
        ship_address: Newgistics::Address.from_spree(order.shipping_address),
        ship_method: Spree::ShippingMethod.find(order.shipping_method_id).code,
        line_items: order.line_items.map{|item| Newgistics::Product.from_spree(item)},
        )
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
