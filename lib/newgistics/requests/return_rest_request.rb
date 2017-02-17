module Newgistics
  class ReturnRestRequest < RestRequest
    attr_accessor :order
    attr_accessor :rma

    DEFAULTS = {}

    def initialize(rma)
      @order = rma.order
      @rma = rma
    end

    def render(options = {})
      addr = @order.shipping_address
      {
        consumer:{
          Address: {
            Address1: addr.address1,
            Address2: addr.address2 ? addr.address2 : "",
            City: addr.city,
            CountryCode: addr.country ? addr.country.iso : "",
            Name: addr.country ? addr.country.name : "",
            State: addr.state ? addr.state.abbr || addr.state.name : "",
            Zip: addr.zipcode
          },
          FirstName: addr.first_name,
          LastName: addr.last_name,
          PrimaryEmailAddress: @order.email
        },
        deliveryMethod: "SelfService",
        labelCount: 1,
        merchantID: ENV['NEWGISTICS_MID'],
        clientServiceFlag: "Standard",
        dispositionRuleSetId: "04",
        returnId: @rma.newgistics_id
      }.to_json
    end
  end
end
