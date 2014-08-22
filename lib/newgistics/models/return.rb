module Newgistics
  class Return
    include Virtus.model(mass_assignment: false)
    include ActiveModel::Validations

    attribute :number, String
    attribute :line_items, Array

    validates :number, presence: true
    validates :line_items, presence: true
  end
end