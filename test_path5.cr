require "path"
p Path["/var/www"].join(Path.posix("/etc/passwd").expand("/").to_kind(Path::Kind.native))
