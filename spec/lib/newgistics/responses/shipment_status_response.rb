require 'spec_helper'

describe Newgistics::ShipmentStatusResponse do
  it 'returns the shipment status' do
    client = Newgistics::Client.new(test: false)
    resp = client.shipment_status(ENV['NEWGISTICS_TEST_ORDER_ID'])
    puts resp.tracking_url
    puts resp.tracking_id
    puts resp.shipping_method
    puts resp.received_at
    puts resp.expected_delivery_date
    puts resp.shipment_status
  end
end