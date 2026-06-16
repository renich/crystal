require "path"
p Path.posix("/etc/passwd").expand("/")
p Path.posix("/../../../etc/passwd").expand("/")
p Path.posix("../../../etc/passwd").expand("/")
p Path.posix("etc/passwd").expand("/")
p Path.posix("\\etc\\passwd").expand("/")
