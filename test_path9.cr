require "path"
require "uri"
p Path.posix(URI.decode("/%2e%2e/etc/passwd")).expand("/")
