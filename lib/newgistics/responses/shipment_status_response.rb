# A lightweight wrapper around the xml shipment response
module Newgistics
  class ShipmentStatusResponse < Newgistics::Response
    # @return [String] the tracking url for the shipment
    def tracking_url
      doc.css('TrackingUrl').try(:text)
    end

    # @return [String] the tracking id for the shipment
    def tracking_id
      doc.css('Tracking').try(:text)
    end

    # @return [String] the shipping id for the shipment
    def order_id
      doc.css('OrderID').try(:text)
    end

    # @return [String] the shipping id for the shipment
    def shipping_id
      doc.css('OrderID').first.parent.attr('id')
    end

    # @return [String] the method used to ship the order
    def shipping_method
      doc.css('ShipMethod').try(:text)
    end

    # @return [Time] the time newgistics received the order
    def received_at
      time = doc.css('ReceivedTimestamp').try(:text)
      Time.parse(time) unless time.blank?
    end

    # @return [Time] the expect date the order should be delivered
    def expected_delivery_date
      time = doc.css('ExpectedDeliveryDate').try(:text)
      Time.parse(time) unless time.blank?
    end

    # @return [Time] when the shipment left newgistics
    def shipped_date
      time = doc.css('ShippedDate').try(:text)
      Time.parse(time) unless time.blank?
    end

    # @return [String] the current status of the shipment {BACKORDER, BADADDRESS, BADSKUHOLD, CANCELED, CNFHOLD, INVHOLD, ONHOLD, PRINTED, RECEIVED, RETURNED, SHIPPED, UPDATED, VERIFIED}
    def shipment_status
      doc.css('ShipmentStatus').text
    end

    # @return [Array][ShippedItem] Shipped Items
    def items
      doc.css('Package').css('Item').map {|item|
        Newgistics::ShippedItemResponse.new(item)
      }
    end

    # @return [Array][ShippedItem] Shipped Items
    def other_items
      doc.css('Item').map {|item|
        Newgistics::ShippedItemResponse.new(item)
      }
    end

  end
end