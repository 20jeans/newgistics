module Newgistics
  module Requests
    class ReturnRequest < Matey::Request
      attr_accessor :rma

      def initialize(rma)
        self.rma = rma
      end
    end
  end
end