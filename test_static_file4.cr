require "uri"
require "path"
p Path.posix(URI.decode("/%2e%2e/etc/passwd")).expand("/")
p Path.posix(URI.decode("/%2E%2E/etc/passwd")).expand("/")
p Path.posix(URI.decode("/%2e%2e%2fetc%2fpasswd")).expand("/")
p Path.posix(URI.decode("/%5c%2e%2e%5cetc%5cpasswd")).expand("/")
