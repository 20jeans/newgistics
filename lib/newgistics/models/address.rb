# A model to represent an address in newgistics
module Newgistics
  class Address
    include Virtus.model(mass_assignment: false)
    include ActiveModel::Validations

    # @return [String] the name of the person at the address
    attribute :name, String
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
  end
end