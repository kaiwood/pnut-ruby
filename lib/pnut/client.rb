require "faraday"
require "json"
require "ostruct"
require "addressable/uri"

module Pnut
  class Client
    def initialize(authorization_token: nil)
      @token = authorization_token
      @connection = Faraday.new("https://api.pnut.io/")
    end

    def get(endpoint, params: nil)
      request(endpoint, method: "GET", params: params)
    end

    def post(endpoint, params: nil, data: nil)
      request(endpoint, method: "POST", params: params, data: data)
    end

    def put(endpoint, params: nil)
      request(endpoint, method: "PUT", params: params)
    end

    def patch(endpoint, params: nil)
      request(endpoint, method: "PATCH", params: params)
    end

    def delete(endpoint, params: nil)
      request(endpoint, method: "DELETE", params: params)
    end

    def request(endpoint, method: "GET", params: nil, data: nil, raw_response: false, json: true)
      prepared_endpoint = "/v0#{endpoint}"

      if params
        uri = Addressable::URI.new
        uri.query_values = params
        prepared_endpoint += "?#{uri.query}"
      end

      response = @connection.send(method.downcase.to_sym, prepared_endpoint) do |req|
        req.url prepared_endpoint

        req.headers["Content-Type"] = "application/json" if json
        req.headers["Authorization"] = "Bearer #{@token}" if @token

        if json
          req.body = data.to_json if data
        else
          req.body = data if data
        end
      end

      raw_response ? response.body : JSON.parse(response.body, object_class: OpenStruct)
    end
  end
end
