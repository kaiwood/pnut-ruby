require "pnut/version"
require "pnut/posts"
require "faraday"
require "json"
require "ostruct"
require "addressable/uri"

module Pnut
  class Client
    include Posts

    def initialize(authorization_token: nil)
      @token = authorization_token
      @connection = Faraday.new("https://api.pnut.io/")
    end

    def request(endpoint, method: "GET", params: nil, data: nil, raw_response: false)
      prepared_endpoint = "/v0#{endpoint}"

      if params
        uri = Addressable::URI.new
        uri.query_values = params
        prepared_endpoint += "?#{uri.query}"
      end

      response = @connection.send(method.downcase.to_sym, prepared_endpoint) do |req|
        req.url prepared_endpoint
        req.headers["Content-Type"] = "application/json"

        req.headers["Authorization"] = "Bearer #{@token}" if @token
        req.body = data.to_json if data
      end

      raw_response ? response.body : JSON.parse(response.body, object_class: OpenStruct)
    end
  end
end
