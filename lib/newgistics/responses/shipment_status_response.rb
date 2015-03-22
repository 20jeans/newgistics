# A lightweight wrapper around the xml shipment response
module Newgistics
  class ShipmentStatusResponse < Newgistics::Response
    # @return [String] the tracking url for the shipment
    def tracking_url
      doc.at('TrackingUrl').try(:text)
    end

    # @return [String] the tracking id for the shipment
    def tracking_id
      doc.at('Tracking').try(:text)
    end

    # @return [String] the method used to ship the order
    def shipping_method
      doc.at('ShipMethod').try(:text)
    end

    # @return [Time] the time newgistics received the order
    def received_at
      time = doc.at('ReceivedTimestamp').try(:text)
      Time.parse(time) unless time.blank?
    end

    # @return [Time] the expect date the order should be delivered
    def expected_delivery_date
      time = doc.at('ExpectedDeliveryDate').try(:text)
      Time.parse(time) unless time.blank?
    end

    # @return [Time] when the shipment left newgistics
    def shipped_date
      time = doc.at('ShippedDate').try(:text)
      Time.parse(time) unless time.blank?
    end

    # @return [String] the current status of the shipment {BACKORDER, BADADDRESS, BADSKUHOLD, CANCELED, CNFHOLD, INVHOLD, ONHOLD, PRINTED, RECEIVED, RETURNED, SHIPPED, UPDATED, VERIFIED}
    def shipment_status
      doc.at('ShipmentStatus').text
    end
  end
end