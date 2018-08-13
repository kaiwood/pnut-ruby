require "pnut/version"
require "pnut/posts"
require "faraday"
require "json"
require "ostruct"
require "addressable/uri"

module Pnut
  class Client
    include Posts

    def initialize
      @connection = Faraday.new("https://api.pnut.io/")
    end

    def request(endpoint, params: nil, raw_response: false)
      prepared_endpoint = "/v0#{endpoint}"

      if params
        uri = Addressable::URI.new
        uri.query_values = params
        prepared_endpoint += "?#{uri.query}"
      end

      response = @connection.get(prepared_endpoint)

      raw_response ? response.body : JSON.parse(response.body, object_class: OpenStruct)
    end
  end
end
