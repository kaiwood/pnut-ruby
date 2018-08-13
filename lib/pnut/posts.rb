module Posts
  def global
    self.request("/posts/streams/global")
  end
end
