module Newgistics
  class ShipmentRestResponse < Newgistics::Response
    # @return [String] the shipping ID for the return
    def shipment_id
      doc.css('ShipmentID').text
    end
    def label_url
      doc.css('href').first.text
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