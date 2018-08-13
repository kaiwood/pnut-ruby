module Posts
  def global
    self.get("/posts/streams/global")
  end
end
