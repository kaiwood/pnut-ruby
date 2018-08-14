# encoding: utf-8

require "eventmachine"
require "faye/websocket"

module Pnut
  module AppStream
    extend self

    def start(access_token: nil, stream_key: nil, handler: method(:puts))
      EM.run do
        ws = Faye::WebSocket::Client.new(
          "wss://stream.pnut.io/v0/app/stream?access_token=#{access_token}&key=#{stream_key}"
        )

        EM.add_periodic_timer 45 do
          ws.ping "ping"
        end

        ws.on :open do |event|
          p [:open]
          ws.send("Hello, pnut!")
        end

        ws.on :message do |event|
          handler.call(event.data)
        end

        ws.on :close do |event|
          p [:close, event.code, event.reason]

          ws = nil
        end
      end
    end
  end
end
