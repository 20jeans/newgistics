require 'active_model'
require 'faraday_middleware'
require 'pry'

module Newgistics
  class Client
    # The base url for the test environment
    TEST_URL = 'https://apistaging.newgisticsfulfillment.com'.freeze
    # The base url for the production environment
    LIVE_URL = 'https://api.newgisticsfulfillment.com'.freeze
    REST_URL = 'https://api.newgistics.com'.freeze
    TEST_REST_URL = 'https://api.newgistics.com'.freeze
    NEW_URL = 'https://api.newgistics.com'.freeze

    # A boolean to determine whether the client is in test mode
    attr_accessor :test
    # Stores the most recent request made to newgistics
    attr_accessor :last_request
    # Stores the most recent response received from newgistics
    attr_accessor :last_response

    def initialize(config = {})
      @test = if config.key?(:test)
        config[:test]
      else
        ENV['TEST_MODE'] == 'true'
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

    # Get a list of inbound returns in newgistics
    #
    # @param startTimeStamp [Time] a Time object
    # @param endTimeStamp [Time] a Time object
    # @return [Array][Newgistics::ReturnResponse] a lightweight wrapper around the xml response
    def inbound_returns(startTimeStamp, endTimeStamp)
      self.last_response = client.get '/inbound_returns.aspx' do |req|
        req.params = {
          key: ENV['NEWGISTICS_KEY'],
          startCreatedTimestamp: startTimeStamp.strftime("%Y-%m-%d"),
          endCreatedTimestamp: endTimeStamp.strftime("%Y-%m-%d")
        }
      end
      Response.new(last_response).doc.css('InboundReturn').map{|ret| Newgistics::InboundReturnResponse.new(ret)}
    end

    # Get a list of received returns in newgistics
    #
    # @param startTimeStamp [Time] a Time object
    # @param endTimeStamp [Time] a Time object
    # @return [Array][Newgistics::ReturnResponse] a lightweight wrapper around the xml response
    def returns(startTimeStamp, endTimeStamp)
      self.last_response = client.get '/returns.aspx' do |req|
        req.params = {
          key: ENV['NEWGISTICS_KEY'],
          startTimeStamp: startTimeStamp.strftime("%Y-%m-%d"),
          endTimeStamp: endTimeStamp.strftime("%Y-%m-%d")
        }
      end
      Response.new(last_response).doc.css('Return').map{|ret| Newgistics::ReturnResponse.new(ret)}
    end

    # Get a list of received returns in newgistics
    #
    # @param startTimeStamp [Time] a Time object
    # @param endTimeStamp [Time] a Time object
    # @return [Array][Newgistics::ReturnResponse] a lightweight wrapper around the xml response
    #
    # to track RMA number, qualifier must be ItemID
    # to track shipment, RMA_NUMBER=TRACKING NUMBER, QUALIFIER='ReferenceNumber' with NO space
    # to track order, RMA_NUMBER=ORDER NUMBER, QUAL=OrderNumber, doesnt always work
    def track_return(rma_number, qualifier="ItemID")
      self.last_request = TrackingRequest.new(rma_number, qualifier)
      send_request('/WebAPI/Shipment/Tracking', TrackingResponse, restclient)
    end

    # Get a list of shipments in newgistics
    #
    # @param startTimeStamp [Time] a Time object
    # @param endTimeStamp [Time] a Time object
    # @return [Array][Newgistics::ReturnResponse] a lightweight wrapper around the xml response
    def shipments(startTimeStamp, endTimeStamp)
      self.last_response = client.get '/shipments.aspx' do |req|
        req.params = {
          key: ENV['NEWGISTICS_KEY'],
          startShippedTimestamp: startTimeStamp.strftime("%Y-%m-%d"),
          endShippedTimestamp: endTimeStamp.strftime("%Y-%m-%d"),
        }
      end
      Response.new(last_response).doc.css('Shipment').map{|ret| Newgistics::ShipmentStatusResponse.new(ret)}
    end

    # Check the status of a shipment in newgistics
    #
    # @param startTimeStamp [Time] a Time object
    # @param endTimeStamp [Time] a Time object
    # @return [Array][Newgistics::ReturnResponse] a lightweight wrapper around the xml response
    def shipments_by_received(startTimeStamp, endTimeStamp)
      self.last_response = client.get '/shipments.aspx' do |req|
        req.params = {
          key: ENV['NEWGISTICS_KEY'],
          startReceivedTimestamp: startTimeStamp.strftime("%Y-%m-%d"),
          endReceivedTimestamp: endTimeStamp.strftime("%Y-%m-%d"),
        }
      end
      Response.new(last_response).doc.css('Shipment').map{|ret| Newgistics::ShipmentStatusResponse.new(ret)}
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

    # Retrieve the shipments associated with an order
    #
    # @param number [String] the order number
    # @return Array of [Newgistics::ShipmentStatusResponse] a lightweight wrapper around the xml response with some helper methods
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

  private

    def send_request(url, response_class, cl = restclient)
      cl.headers.merge!(last_request.headers)
      # return false unless last_request.valid?
      self.last_response = cl.post do |req|
        req.params = {
          key: ENV['NEWGISTICS_NEW_KEY']
        }
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

    def restclient
      @_client ||= Faraday.new (@test ? TEST_REST_URL : REST_URL) do |conn|
        conn.use :instrumentation
        conn.adapter Faraday.default_adapter
      end
    end
  end
end