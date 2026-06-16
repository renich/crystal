require "path"
p Path.posix("/%2e%2e/etc/passwd").expand("/")
