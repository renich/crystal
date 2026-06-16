require "path"
p Path.posix("etc/passwd").expand("/").to_kind(Path::Kind.native)
