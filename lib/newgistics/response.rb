require 'nokogiri'

module Newgistics
  class Response
    attr_accessor :response

    def initialize(response)
      @response = response
    end

    # @return [Nokogiri::Document] returns a nokogiri document object
    def doc
      @_doc ||= @response.class == Faraday::Response ? ::Nokogiri::XML(response.body.gsub("\r\n",'')) : @response
    end
  end
end