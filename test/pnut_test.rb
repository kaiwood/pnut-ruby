require "test_helper"
require "webmock"
require "pry"
include WebMock::API

WebMock.enable!

API_RESPONSE_STREAM = File.read("test/api_response_stream.txt")

stub_request(:get, "https://api.pnut.io/v0/posts/streams/global").
  to_return(status: 200, body: API_RESPONSE_STREAM, headers: {})

class PnutTest < Minitest::Test
  def setup
    @pnut = Pnut::Client.new
    @parsed_api_response = JSON.parse(API_RESPONSE_STREAM)
  end

  def test_that_it_has_a_version_number
    refute_nil ::Pnut::VERSION
  end

  def test_that_it_can_create_a_pnut_client
    assert_instance_of Pnut::Client, @pnut
  end

  def test_for_meta_and_data_attributes
    response = @pnut.global

    assert_equal @parsed_api_response["meta"]["code"], response.meta.code
    assert_equal @parsed_api_response["data"][0]["id"], response.data[0].id
  end
end
