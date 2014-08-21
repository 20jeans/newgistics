module Newgistics
  class Address
    include ActiveModel::Validations

    attr_accessor :name,
                  :address1,
                  :address2,
                  :city,
                  :state,
                  :postal_code,
                  :country,
                  :phone,
                  :fax,
                  :type

    alias_method :zip, :postal_code
    alias_method :postal, :postal_code
    alias_method :province, :state
    alias_method :territory, :province
    alias_method :region, :province

    validates :address1, presence: true
    validates :postal_code, presence: true
  end
end