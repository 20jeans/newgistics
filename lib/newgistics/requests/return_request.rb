module Newgistics
  class ReturnRequest < Newgistics::Request
    attr_accessor :rma

    def initialize(rma)
      self.rma = rma
    end

    def valid?
      rma.valid?
    end

    def errors
      rma.errors.full_messages
    end
  end
end