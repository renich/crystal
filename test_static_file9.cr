require "uri"
require "path"
p Path.posix(URI.decode("/%5c%2e%2e%5cetc%5cpasswd")).expand("/").to_kind(Path::Kind.native)
