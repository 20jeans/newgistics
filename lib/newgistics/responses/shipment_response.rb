module Newgistics
  class ShipmentResponse < Newgistics::Response
    def order_id
      doc.css('shipment').attr('orderID').value
    end

    def shipment_id
      doc.css('shipment').attr('id').value
    end

    def warnings
      doc.css('warning').map{|warning| warning.text}
    end

    def errors
      doc.css('error').map{|err| err.text}
    end
  end
end