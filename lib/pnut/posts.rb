module Posts
  # <em>GET /posts/streams/global</em>
  #
  # A stream of all users' public posts.
  def global(**args)
    self.request("/posts/streams/global", params: args)
  end
end
