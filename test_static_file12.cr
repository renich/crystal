require "uri"
require "path"
p Path.posix(URI.decode("/%5c%2e%2e%5cetc%5cpasswd")).expand("/")
p Path.posix(URI.decode("/%5c%2e%2e%5cetc%5cpasswd")).expand("/").to_kind(Path::Kind.native)
p Path["/var/www"].join(Path.posix(URI.decode("/%5c%2e%2e%5cetc%5cpasswd")).expand("/").to_kind(Path::Kind.native))

p "test2"
p Path.posix(URI.decode("/\\..\\etc\\passwd")).expand("/")
p Path.posix(URI.decode("/\\..\\etc\\passwd")).expand("/").to_kind(Path::Kind.native)
p Path["/var/www"].join(Path.posix(URI.decode("/\\..\\etc\\passwd")).expand("/").to_kind(Path::Kind.native))
