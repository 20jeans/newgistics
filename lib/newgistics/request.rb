require "active_model"
require "tilt"

module Newgistics
  class Request
    include ActiveModel::Validations

    DEFAULTS = {}

    attr_accessor :client

    def render(options = {})
      options.reverse_merge!(DEFAULTS)
      template = Tilt.new("newgistics/views#{self.class.name.gsub('Newgistics','').underscore}.slim")
      template.render(self, options: options)
    end

    protected

    def partial(name, options = {})
      carrier = self.class.to_s.split('::')[1]
      template = Tilt.new("newgistics/views/partials/_#{name}.slim")
      template.render(self, options)
    end
  end
end