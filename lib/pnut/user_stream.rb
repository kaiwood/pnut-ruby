require "eventmachine"
require "faye/websocket"

module Pnut
  module UserStream
    extend self

    def start(access_token: nil,
              on_open: nil,
              on_message: method(:puts),
              on_close: nil)
      EM.run do
        ws = Faye::WebSocket::Client.new(
          "wss://stream.pnut.io/v0/user?access_token=#{access_token}"
        )

        EM.add_periodic_timer 45 do
          ws.ping "ping"
        end

        ws.on :open do |event|
          on_open.call(event) if on_open
        end

        ws.on :message do |event|
          on_message.call(event.data) if on_message
        end

        ws.on :close do |event|
          on_close.call(event) if on_close
          ws = nil
        end
      end
    end
  end
end
