require "uri"
p URI.decode("/%2e%2e/etc/passwd")
p URI.decode("/%2E%2E/etc/passwd")
