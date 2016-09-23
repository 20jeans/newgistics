module Newgistics
  class TrackingEvent
    def initialize(event)
      @doc = event
    end

    def description
      doc.css('Description').select{|e| e.text}.map{|e| e.text}.first
    end

    def timestamp
      Time.parse(doc.css('Time').text)
    end

    def state
      doc.css('State').text
    end

    def key
      doc.css('TrackingKey').text
    end

    def doc
      @doc
    end
  end
end