# A model to represent an address in newgistics
require 'active_model'
module Newgistics
  class Address
    include Virtus.model
    include ActiveModel::Validations

    # @return [String] the first name of the person at the address
    attribute :firstname, String
    # @return [String] the last name of the person at the address
    attribute :lastname, String
    # @return [String] the street address (required)
    attribute :address1, String
    # @return [String] the suite/apartment number
    attribute :address2, String
    # @return [String] the city of the address
    attribute :city, String
    # @return [String] the state/province of the address
    attribute :state, String
    # @return [String] the zipcode/postal code of the address (required)
    attribute :postal_code, String
    # @return [String] the country of the address
    attribute :country, String
    # @return [String] the phone number associated with the address
    attribute :phone, String
    # @return [String] the address type (residential/commercial)
    attribute :type, String

    # alias for postal code
    alias_method :zip, :postal_code
    # alias for postal code
    alias_method :postal, :postal_code
    # alias for state
    alias_method :province, :state
    # alias for state
    alias_method :territory, :state
    # alias for state
    alias_method :region, :state

    validates :address1, presence: true
    validates :postal_code, presence: true

    def self.from_spree(addr)
      self.new(
          { firstname:  addr.firstname,
            lastname:   addr.lastname,
            address1:   addr.address1,
            address2:   addr.address2,
            city:       addr.city,
            state:      addr.state_name,
            country:    addr.country.name,
            postal_code:addr.zipcode,
            phone:      addr.phone,
            type:       addr.address_type || 'residential'
          })
    end
  end
end