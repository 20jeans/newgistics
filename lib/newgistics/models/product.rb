module Newgistics
  class Product
    include ActiveModel::Validations

    attr_accessor :sku

    validates :sku, presence: true
  end
end