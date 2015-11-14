module Newgistics
  class ShippedItemResponse < Newgistics::Response
    # @return [String] the item SKU
    def sku
      doc.css('SKU').first.text
    end

    # @return [Int] the number returned
    def quantity
      doc.css('Qty').first.text.to_i
    end
  end
end