require 'active_model'

module Newgistics
  class Client
    TEST_URL = 'apistaging.newgisticsfulfillment.com'.freeze
    LIVE_URL = 'api.newgisticsfulfillment.com'.freeze
    include ActiveModel::Validations

    attr_accessor :test, :last_request, :last_response

    def initialize(configuration = {})
      @test = configuration[:test] || ENV['TEST_MODE'] || false
    end

    def list_manifests(options = {})
      self.last_response = client.get do |req|
        req.url '/manifests.aspx'
        req.params = {
          key: ENV['NEWGISTICS_KEY']
        }.merge(options)
      end
      Responses::ManifestResponse.new(last_response)
    end

    def create_product(products)
      self.last_request = Requests::ProductRequest.new(products)
      return last_request.errors unless last_request.valid?
      self.last_response = client.post do |req|
        req.url '/post_products.aspx'
        req.body = last_request.render(options)
      end
      Responses::ProductResponse.new(last_response)
    end

    def create_shipment(shipment)
      self.last_request = Requests::ShipmentRequest.new(products)
      return last_request.errors unless last_request.valid?
      self.last_response = client.post do |req|
        req.url '/post_shipments.aspx'
        req.body = last_request.render(options)
      end
      Responses::ShipmentResponse.new(last_response)
    end

    def create_return(rma)
      self.last_request = Requests::ReturnRequest.new(products)
      return last_request.errors unless last_request.valid?
      self.last_response = client.post do |req|
        req.url '/post_inbound_returns.aspx'
        req.body = last_request.render(options)
      end
      Responses::ReturnResponse.new(last_response)
    end

    protected

    def client
      @_client ||= Faraday.new (@test ? TEST_URL : LIVE_URL) do |conn|
        conn.response :xml, content_type: /\bxml$/
        conn.use :instrumentation
        conn.adapter Faraday.default_adapter
      end
    end
  end
end