module Newgistics
  class InboundReturnResponse < Newgistics::Response
    # @return [String] the shipping ID for the return
    def shipping_id
      doc.css('ShipmentID').text
    end

    # @return [String] the order ID for the return
    def order_id
      mo = doc.css('OrderID').text.match(/(R\d{9})\W*([\w^_]*)/)
      mo.nil? ? nil : mo[1]
    end

    def timestamp
      Time.xmlschema(doc.css('CreateTimestamp').text)
    end

    # @return [Array][ReturnedItem] Returned Items
    def items
      doc.css('Item').map{|item|
        Newgistics::ReturnedItemResponse.new(item)
      }
    end

    def rma
      doc.css('RMA').text
    end

    def tracking
      doc.css('CarrierTracking').text
    end

  end
end