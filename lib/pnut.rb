require "pnut/version"
require "pnut/posts"
require "faraday"
require "json"
require "ostruct"

module Pnut
  class Client
    include Posts

    def initialize
      @connection = Faraday.new("https://api.pnut.io/")
    end

    def request(endpoint, raw_response: false)
      response = @connection.get("/v0#{endpoint}")

      if raw_response
        response.body
      else
        JSON.parse(response.body, object_class: OpenStruct)
      end
    end
  end
end
