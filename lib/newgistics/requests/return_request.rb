module Newgistics
  class ReturnRequest < Newgistics::Request
    # @return [Newgistics::Return] a model representing the return
    attr_accessor :rma

    def initialize(rma)
      self.rma = rma
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