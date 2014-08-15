require "newgistics/version"

require "active_support/core_ext"

module Newgistics
  # Your code goes here...
  autoload :Client, "newgistics/client"
  autoload :Request, "newgistics/request"
  autoload :Response, "newgistics/response"
end