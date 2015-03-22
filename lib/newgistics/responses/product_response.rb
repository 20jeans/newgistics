# A light weight wrapper around the xml product response
module Newgistics
  class ProductResponse < Newgistics::Response
    # @return [Array] an array of product elements in the response
    def products
      doc.search('product')
    end
  end
end