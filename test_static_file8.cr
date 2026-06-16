require "uri"
require "path"
p Path["/var/www"].join(Path.posix(URI.decode("/%5c%2e%2e%5cetc%5cpasswd")).expand("/").to_kind(Path::Kind.native))
p Path["/var/www"].join(Path.windows(URI.decode("/%5c%2e%2e%5cetc%5cpasswd")).expand("\\").to_kind(Path::Kind.native))
p Path.windows(URI.decode("/%5c%2e%2e%5cetc%5cpasswd")).expand("\\").to_kind(Path::Kind.native)
