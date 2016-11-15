module Newgistics
  class InventoryResponse < Newgistics::Response
    def products
      doc.css('product').map{|elem|
        InventoryProduct.new(elem)
      }
    end
  end
end