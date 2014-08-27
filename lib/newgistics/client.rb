require 'active_model'
require 'faraday_middleware'

module Newgistics
  class Client
    TEST_URL = 'https://apistaging.newgisticsfulfillment.com'.freeze
    LIVE_URL = 'https://api.newgisticsfulfillment.com'.freeze

    attr_accessor :test, :last_request, :last_response

    def initialize(config = {})
      @test = config[:test] || ENV['TEST_MODE'] || false
    end

    def list_inventory(options = {})
      self.last_response = client.get do |req|
        req.url '/inventory.aspx'
        req.params = {
          key: ENV['NEWGISTICS_KEY']
        }.merge(options)
      end
      InventoryResponse.new(last_response)
    end

    def create_products(products)
      request('/post_products.aspx', ProductRequest, ProductResponse)
    end

    def create_shipment(shipment)
      request('/post_shipments.aspx', ShipmentRequest, ShipmentResponse)
    end

    def create_return(rma)
      request('/post_inbound_returns.aspx', ReturnRequest, ReturnResponse)
    end

    protected

    def request(url, request_class, response_class)
      self.last_request = request_class.new(products)
      return last_request.errors unless last_request.valid?
      self.last_response = client.post do |req|
        req.url url
        req.body = last_request.render
      end
      response_class.new(last_response)
    end

    def client
      @_client ||= Faraday.new (@test ? TEST_URL : LIVE_URL) do |conn|
        conn.use :instrumentation
        conn.adapter Faraday.default_adapter
      end
    end
  end
end