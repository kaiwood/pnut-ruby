module Posts
  # <em>GET /posts/streams/global</em>
  #
  # A stream of all users' public posts.
  def global(**args)
    self.request("/posts/streams/global", params: args)
  end

  # <em>GET /posts/streams/unified</em>
  #
  # A combined Personal Stream including the authenticated user's mentions.
  def unified(**args)
    self.request("/posts/streams/unified", params: args)
  end
end
