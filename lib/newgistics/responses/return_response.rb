module Newgistics
  class ReturnResponse < Newgistics::Response
    # @return [String] the shipping ID for the return
    def shipping_id
      doc.attr('shipmentID')
    end

    # @return [String] the order ID for the return
    def order_id
      doc.attr('orderID').split(' ').first
    end

    # @return [String] the order ID for the return
    def original_shipping_id
      doc.attr('orderID').split(' ')[2]
    end

    # @return [String] the status for the return
    def notes
      doc.css('Note').map{|note| note.text}
    end

    # @return [String] the status for the return
    def status
      doc.css('Status').text
    end

    # @return [Array][ReturnedItem] Returned Items
    def items
      doc.css('Item').map{|item|
        Newgistics::ReturnedItemResponse.new(item)
      }
    end

  end
end