$:.unshift File.dirname(__FILE__)

require "dotenv"

Dotenv.load

require "newgistics/version"
require "active_support/core_ext"
require "virtus"

module Newgistics
  autoload :Client, "newgistics/client"
  autoload :Request, "newgistics/request"
  autoload :Response, "newgistics/response"

  ## Models
  autoload :Address, "newgistics/models/address"
  autoload :Product, "newgistics/models/product"
  autoload :Return, "newgistics/models/return"
  autoload :Shipment, "newgistics/models/shipment"

  ## Requests
  autoload :ProductRequest, "newgistics/requests/product_request"
  autoload :ReturnRequest, "newgistics/requests/return_request"
  autoload :ShipmentRequest, "newgistics/requests/shipment_request"
  autoload :ReturnRestRequest, "newgistics/requests/return_rest_request"
  autoload :RestRequest, "newgistics/requests/rest_request"
  autoload :TrackingRequest, "newgistics/requests/tracking_request"

  ## Response
  autoload :ProductResponse, "newgistics/responses/product_response"
  autoload :ReturnResponse, "newgistics/responses/return_response"
  autoload :InboundReturnResponse, "newgistics/responses/inbound_return_response"
  autoload :InboundReturnCreateResponse, "newgistics/responses/inbound_return_create_response"
  autoload :ReturnedItemResponse, "newgistics/responses/returned_item_response"
  autoload :ShipmentResponse, "newgistics/responses/shipment_response"
  autoload :ShipmentRestResponse, "newgistics/responses/shipment_rest_response"
  autoload :ShippedItemResponse, "newgistics/responses/shipped_item_response"
  autoload :InventoryResponse, "newgistics/responses/inventory_response"
  autoload :InventoryProduct, "newgistics/responses/inventory_product"
  autoload :ShipmentStatusResponse, "newgistics/responses/shipment_status_response"
  autoload :TrackingResponse, "newgistics/responses/tracking_response"
  autoload :TrackingEvent, "newgistics/responses/tracking_event"
end