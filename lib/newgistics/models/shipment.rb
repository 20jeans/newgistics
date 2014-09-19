module Newgistics
  class Shipment
    include Virtus.model(mass_assignment: true)
    include ActiveModel::Validations

    attribute :number, String
    attribute :email, String
    attribute :completed_at, DateTime
    attribute :ship_address, Newgistics::Address
    attribute :ship_method, String
    attribute :line_items, Array
    attribute :options, Hash, default: {}

    validates :number, presence: true
    validates :completed_at, presence: true
    validates :line_items, presence: true
  end
end