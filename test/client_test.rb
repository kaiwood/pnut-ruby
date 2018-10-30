require "test_helper"

stub_request(:get, "https://api.pnut.io/v0/posts/streams/global").
  to_return(status: 200, body: API_RESPONSE_STREAM, headers: {})

stub_request(:get, "https://api.pnut.io/v0/posts/streams/global?since_id=436277").
  to_return(status: 200, body: API_RESPONSE_STREAM_LIMITED, headers: {})

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
    response = @pnut.request("/posts/streams/global")

    assert_equal @parsed_api_response["meta"]["code"], response.meta.code
    assert_equal @parsed_api_response["data"][0]["id"], response.data[0].id
  end

  def test_that_it_can_give_raw_responses_back
    assert_instance_of Array, @pnut.request("/posts/streams/global").data
    assert_instance_of String, @pnut.request("/posts/streams/global", raw_response: true)
  end

  def test_that_it_can_handle_additional_parameters
    assert_equal 7, @pnut.request("/posts/streams/global?since_id=436277").data.size
    assert_equal 7, @pnut.request("/posts/streams/global", params: {since_id: 436277}).data.size
  end
end
