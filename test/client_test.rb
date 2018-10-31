require "test_helper"

stub_request(:get, "https://api.pnut.io/v0/posts/streams/global")
  .to_return(status: 200, body: API_RESPONSE_STREAM, headers: {})

stub_request(:get, "https://api.pnut.io/v0/posts/streams/global?since_id=436277")
  .to_return(status: 200, body: API_RESPONSE_STREAM_LIMITED, headers: {})

stub_request(:get, "https://api.pnut.io/v0/test/route")
  .to_return(status: 200, body: '{"meta": 200}', headers: {})

stub_request(:get, "https://api.pnut.io/v0/test/route?test=1")
  .to_return(status: 200, body: '{"meta": 200}', headers: {})

stub_request(:post, "https://api.pnut.io/v0/test/route")
  .to_return(status: 200, body: '{"meta": 200}', headers: {})

stub_request(:post, "https://api.pnut.io/v0/test/route?test=1")
  .to_return(status: 200, body: '{"meta": 200}', headers: {})

stub_request(:put, "https://api.pnut.io/v0/test/route")
  .to_return(status: 200, body: '{"meta": 200}', headers: {})

stub_request(:put, "https://api.pnut.io/v0/test/route?test=1")
  .to_return(status: 200, body: '{"meta": 200}', headers: {})

stub_request(:patch, "https://api.pnut.io/v0/test/route")
  .to_return(status: 200, body: '{"meta": 200}', headers: {})

stub_request(:patch, "https://api.pnut.io/v0/test/route?test=1")
  .to_return(status: 200, body: '{"meta": 200}', headers: {})

stub_request(:delete, "https://api.pnut.io/v0/test/route")
  .to_return(status: 200, body: '{"meta": 200}', headers: {})

stub_request(:delete, "https://api.pnut.io/v0/test/route?test=1")
  .to_return(status: 200, body: '{"meta": 200}', headers: {})

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

  def test_that_it_supports_http_get
    assert_equal 200, @pnut.get("/test/route").meta
    assert_equal 200, @pnut.get("/test/route", params: {test: 1}).meta
  end

  def test_that_it_supports_http_post
    assert_equal 200, @pnut.post("/test/route").meta
    assert_equal 200, @pnut.post("/test/route", params: {test: 1}).meta
  end

  def test_that_it_supports_http_put
    assert_equal 200, @pnut.put("/test/route").meta
    assert_equal 200, @pnut.put("/test/route", params: {test: 1}).meta
  end

  def test_that_it_supports_http_patch
    assert_equal 200, @pnut.patch("/test/route").meta
    assert_equal 200, @pnut.patch("/test/route", params: {test: 1}).meta
  end

  def test_that_it_supports_http_delete
    assert_equal 200, @pnut.delete("/test/route").meta
    assert_equal 200, @pnut.delete("/test/route", params: {test: 1}).meta
  end
end
