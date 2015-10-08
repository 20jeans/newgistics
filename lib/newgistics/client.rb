require 'active_model'
require 'faraday_middleware'

module Newgistics
  class Client
    # The base url for the test environment
    TEST_URL = 'https://apistaging.newgisticsfulfillment.com'.freeze
    # The base url for the production environment
    LIVE_URL = 'https://api.newgisticsfulfillment.com'.freeze

    # A boolean to determine whether the client is in test mode
    attr_accessor :test
    # Stores the most recent request made to newgistics
    attr_accessor :last_request
    # Stores the most recent response received from newgistics
    attr_accessor :last_response

    def initialize(config = {})
      @test = if config.key?(:test)
        config[:test]
      elsif ENV['TEST_MODE'] == 'true'
        true
      else
        false
      end
    end

    # Lists the inventory currently in newgistics
    #
    # @return [Newgistics::InventoryResponse] An InventoryResponse object
    def list_inventory
      self.last_response = client.get do |req|
        req.url '/inventory.aspx'
        req.params = {
          key: ENV['NEWGISTICS_KEY']
        }
      end
      InventoryResponse.new(last_response)
    end

    # Creates a new product(s) in newgistics
    #
    # @param products [Array<Newgistics::Product>] an array of Newgistics::Products
    # @return [Newgistics::ProductResponse] a lightweight wrapper around the xml response
    def create_products(products)
      self.last_request = ProductRequest.new(products)
      send_request('/post_products.aspx', ProductResponse)
    end

    # Creates a new shipment in newgistics
    #
    # @param shipment [Newgistics::Shipment] a Newgistics::Shipment object
    # @return [Newgistics::ShipmentResponse] a lightweight wrapper around the xml response
    def create_shipment(shipment)
      self.last_request = ShipmentRequest.new(shipment)
      send_request('/post_shipments.aspx', ShipmentResponse)
    end

    # Creates a new return in newgistics
    #
    # @param rma [Newgistics::Return] a Newgistics::Return object
    # @return [Newgistics::ReturnResponse] a lightweight wrapper around the xml response
    def create_return(rma)
      self.last_request = ReturnRequest.new(rma)
      send_request('/post_inbound_returns.aspx', ReturnResponse)
    end

    # Check the status of a shipment in newgistics
    #
    # @param shipment_id [String] the id of the shipment to track
    # @return [Newgistics::ShipmentStatusResponse] a lightweight wrapper around the xml response with some helper methods
    def shipment_status(shipment_id)
      self.last_response = client.get '/shipments.aspx' do |req|
        req.params = {
          key: ENV['NEWGISTICS_KEY'],
          shipmentId: shipment_id
        }
      end
      ShipmentStatusResponse.new(last_response)
    end

    # Check the status of a shipment in newgistics
    #
    # @param shipment_id [String] the id of the shipment to track
    # @return [Newgistics::ShipmentStatusResponse] a lightweight wrapper around the xml response with some helper methods
    def order_shipments(number)
      self.last_response = client.get '/shipments.aspx' do |req|
        req.params = {
          key: ENV['NEWGISTICS_KEY'],
          id: number
        }
      end
      ng_response = Newgistics::Response.new(last_response)
      ng_response.doc.css('Shipments Shipment').map{|response|
        ShipmentStatusResponse.new(response)
      }
    end

    protected

    def send_request(url, response_class)
      return false unless last_request.valid?
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