require "path"
p File.expand_path(Path["/var/www"].join(Path["/\\..\\etc\\passwd"]).to_s)
