$:.unshift File.dirname(__FILE__)

require 'dotenv'
Dotenv.load

require "newgistics/version"
require "active_support/core_ext"

module Newgistics
  # Your code goes here...
  autoload :Client, "newgistics/client"
  autoload :Request, "newgistics/request"
  autoload :Response, "newgistics/response"

  ## Models
  autoload :Product, "newgistics/models/product"
  autoload :Return, "newgistics/models/return"
  autoload :Shipment, "newgistics/models/shipment"

  ## Requests
  autoload :ProductRequest, "newgistics/requests/product_request"
  autoload :ReturnRequest, "newgistics/requests/return_request"
  autoload :ShipmentRequest, "newgistics/requests/shipment_request"

  ## Response
  autoload :ProductResponse, "newgistics/responses/product_response"
  autoload :ReturnResponse, "newgistics/responses/return_response"
  autoload :ShipmentResponse, "newgistics/responses/shipment_response"
  autoload :ManifestResponse, "newgistics/responses/manifest_response"
end