module Newgistics
  class ShipmentResponse < Newgistics::Response
    def order_id
      doc.css('shipment').attr('orderID').value
    end

    def shipment_id
      doc.css('shipment').attr('id').value
    end
  end
end