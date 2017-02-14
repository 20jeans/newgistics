module Newgistics
  class InboundReturnCreateResponse < Newgistics::Response
    # @return [String] the shipping ID for the return
    def shipping_id
      doc.css('Return').attribute('ShipmentID')
    end

    # @return [String] the order ID for the return
    def order_id
      doc.css('Return').attribute('OrderID')
    end

    # @return [String] the Return ID for the return
    def order_id
      doc.css('Return').attribute('ID')
    end

    def rma
      doc.css('Return').attribute('RMA')
    end

    def errors
      doc.css('Errors').map{|err|
        err.text
      }.select{|err_text| err_text.length > 0}
    end

    def warnings
      doc.css('Warnings').map{|err|
        err.text
      }.select{|err_text| err_text.length > 0}
    end
  end
end