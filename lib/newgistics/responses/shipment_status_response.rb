module Newgistics
  class ShipmentStatusResponse < Newgistics::Response
    def tracking_url
      doc.at('TrackingUrl').try(:text)
    end

    def tracking_id
      doc.at('Tracking').try(:text)
    end

    def shipping_method
      doc.at('ShipMethod').try(:text)
    end

    def received_at
      time = doc.at('ReceivedTimestamp').try(:text)
      Time.parse(time) unless time.blank?
    end

    def expected_delivery_date
      time = doc.at('ExpectedDeliveryDate').try(:text)
      Time.parse(time) unless time.blank?
    end

    def shipment_status
      doc.at('ShipmentStatus').text
    end
  end
end