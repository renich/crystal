require "path"
p Path.posix("/%2e%2e/etc/passwd").expand("/")
p Path.posix("/../etc/passwd").expand("/")
p Path.posix("/../../etc/passwd").expand("/")
