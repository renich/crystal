require "path"
p Path.posix("/etc/passwd").expand("/").normalize
