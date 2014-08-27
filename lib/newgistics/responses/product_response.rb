module Newgistics
  class ProductResponse < Newgistics::Response
    def products
      doc.search('product')
    end
  end
end