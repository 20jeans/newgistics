module Newgistics
  class ReturnRequest < Newgistics::Request
    attr_accessor :rma

    def initialize(rma)
      self.rma = rma
    end
  end
end