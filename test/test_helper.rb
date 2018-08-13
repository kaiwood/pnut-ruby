$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "pnut"
require "webmock"
require "pry"

require "minitest/autorun"

include WebMock::API

WebMock.enable!

API_RESPONSE_STREAM = File.read("test/api_response_stream.txt")
API_RESPONSE_STREAM_LIMITED = File.read("test/api_response_stream_only_7_posts.txt")
