require 'nokogiri'

module Newgistics
  class Response
    attr_accessor :response

    def initialize(response)
      @response = response
    end

    def doc
      @_doc ||= ::Nokogiri::XML(response.body.gsub("\r\n",''))
    end
  end
end