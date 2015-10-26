module Newgistics
  class ReturnedItemResponse < Newgistics::Response
    # @return [String] the item SKU
    def sku
      doc.css('SKU').first.text
    end

    # @return [String] the return reason
    def reason
      doc.css('ReturnReason').first.text
    end

    # @return [Int] the number returned
    def num_returned
      doc.css('QtyReturned').first.text.to_i
    end

    # @return [Int] the number returned to stock
    def num_returned_stock
      doc.css('QtyReturnedToStock').first.text.to_i
    end

  end
end