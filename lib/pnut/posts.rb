module Posts
  def global(**args)
    self.request("/posts/streams/global", params: args)
  end
end
