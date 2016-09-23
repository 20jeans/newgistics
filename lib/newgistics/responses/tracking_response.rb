module Newgistics
  class TrackingResponse < Newgistics::Response
    # @return [String] the shipping ID for the return
    def shipping_id
      doc.attr('shipmentID')
    end

    # @return [String] the order ID for the return
    def reference_number
      # mo = doc.attr('orderID').match(/(R\d{9})\W*([\w^_]*)/)
      # mo.nil? ? nil : mo[1]
      doc.css("ReferenceNumber").text
    end

    def tracking_number
      doc.search("TrackingNumber").text
    end

    def picked_up_timestamp
      doc.css("PackageTrackingEvent").select {|e|
        e.search("EventCode").text == "PUU"
      }.select{|ts| ts.search("Time").text}.first
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

    # @return [String] the email of the return
    def email
      doc.css('Email').text.downcase
    end

    # @return [String] the email of the return
    def zipcode
      doc.css('PostalCode').text
    end

    # @return [String] the first name of the return
    def firstname
      doc.css('FirstName').text.downcase
    end

    # @return [String] the last name of the return
    def lastname
      doc.css('LastName').text
    end

    def timestamp
      Time.xmlschema(doc.css('Time').text)
    end

    def events
      doc.css('PackageTrackingEvent').map{|edoc| TrackingEvent.new(edoc)}
    end

    # @return [Array][ReturnedItem] Returned Items
    def items
      doc.css('Item').map{|item|
        Newgistics::ReturnedItemResponse.new(item)
      }
    end

  end
end