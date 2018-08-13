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

    def get(endpoint)
      response = @connection.get("/v0#{endpoint}")
      JSON.parse(response.body, object_class: OpenStruct)
    end
  end
end
