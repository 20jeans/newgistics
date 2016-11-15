module Newgistics
  class InventoryProduct
    def initialize(elem)
      @elem = elem
    end

    def id
      @elem.attributes['id'].value
    end

    def sku
      @elem.attributes['sku'].value
    end

    def to_h
      {"sku" => sku, "id" => id}.merge(properties)
    end

    def properties
      @elem.element_children.map{|elem| [elem.name, elem.content]}.to_h
    end
  end
end