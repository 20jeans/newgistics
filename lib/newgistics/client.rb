require 'active_model'
require 'faraday_middleware'

module Newgistics
  class Client
    TEST_URL = 'https://apistaging.newgisticsfulfillment.com'.freeze
    LIVE_URL = 'https://api.newgisticsfulfillment.com'.freeze
    include ActiveModel::Validations

    attr_accessor :test, :last_request, :last_response

    def initialize(config = {})
      @test = config[:test] || ENV['TEST_MODE'] || false
    end

    def list_manifests(options = {})
      self.last_response = client.get do |req|
        req.url '/manifests.aspx'
        req.params = {
          key: ENV['NEWGISTICS_KEY']
        }.merge(options)
      end
      ManifestResponse.new(last_response)
    end

    def create_products(products)
      self.last_request = ProductRequest.new(products)
      return last_request.errors unless last_request.valid?
      self.last_response = client.post do |req|
        req.url '/post_products.aspx'
        req.body = last_request.render
      end
      ProductResponse.new(last_response)
    end

    def create_shipment(shipment)
      self.last_request = ShipmentRequest.new(products)
      return last_request.errors unless last_request.valid?
      self.last_response = client.post do |req|
        req.url '/post_shipments.aspx'
        req.body = last_request.render
      end
      ShipmentResponse.new(last_response)
    end

    def create_return(rma)
      self.last_request = ReturnRequest.new(products)
      return last_request.errors unless last_request.valid?
      self.last_response = client.post do |req|
        req.url '/post_inbound_returns.aspx'
        req.body = last_request.render
      end
      ReturnResponse.new(last_response)
    end

    protected

    def client
      @_client ||= Faraday.new (@test ? TEST_URL : LIVE_URL) do |conn|
        conn.use :instrumentation
        conn.adapter Faraday.default_adapter
      end
    end
  end
end