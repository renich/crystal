require "http/server"
server = HTTP::Server.new([
  HTTP::StaticFileHandler.new("public")
])
