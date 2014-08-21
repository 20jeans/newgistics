module Newgistics
  class Product
    include ActiveModel::Validations

    attr_accessor :name, :sku

    validates :name, presence: true
    validates :sku, presence: true
  end
end