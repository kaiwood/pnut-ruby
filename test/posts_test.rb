require "test_helper"

stub_request(:get, "https://api.pnut.io/v0/posts/streams/unified").
  to_return(status: 200, body: [].to_s, headers: {})

class PostsTest < Minitest::Test
  def setup
    @pnut = Pnut::Client.new
  end

  def test_unified
    response = @pnut.unified
    assert_equal [], response
  end
end
