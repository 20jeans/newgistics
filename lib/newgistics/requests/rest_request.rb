module Newgistics
  class RestRequest < Newgistics::Request

    DEFAULTS = {}

    def headers
      {
        'User-Agent' => 'Fiddler',
        "Content-type" => "application/json; charset=utf-8",
        "x-API-Key" => ENV['NEWGISTICS_NEW_KEY']
      }
    end

  end
end
