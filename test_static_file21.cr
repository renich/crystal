require "path"
p Path.posix("/\\..\\etc\\passwd").to_kind(Path::Kind.windows)
