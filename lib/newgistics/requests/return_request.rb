module Newgistics
  class ReturnRequest < Newgistics::Request
    # @return [Newgistics::Return] a model representing the return
    attr_accessor :rma
    attr_accessor :shipment
    attr_accessor :skus

    DEFAULTS = {}

    def headers
      {
        'User-Agent' => 'Fiddler',
        "Content-type" => "application/json; charset=utf-8",
      }
    end

    def initialize(rma, shipment)
      @rma = rma
      @shipment = shipment
      @skus = {}
      rma.inventory_units.each{|unit|
        @skus[unit.variant.sku] = (@skus[unit.variant.sku] || 0) + 1
      }
    end

    # @return [Boolean] returns whether the rma is valid or not
    def valid?
      rma.valid?
    end

    # @return [Array<String>] returns an array of error messages
    def errors
      rma.errors.full_messages
    end
  end
end
