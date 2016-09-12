module Newgistics
  class TrackingRequest < RestRequest
    # @return [Newgistics::Return] a model representing the return
    attr_accessor :number

    DEFAULTS = {}

    def initialize(number)
      @number = number
    end

    def render(options = {})
      {
        merchantID: ENV['NEWGISTICS_MID'],
        qualifier: "Reference Number",
        searchStrings: [@number]
      }.to_json
    end

    # @return [Boolean] returns whether the rma is valid or not
    def valid?
      @number.length == 11
    end

    # @return [Array<String>] returns an array of error messages
    def errors
      []
    end
  end
end