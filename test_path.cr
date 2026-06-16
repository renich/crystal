require "path"
p Path["/var/www"].join(Path["/etc/passwd"])
p Path["/var/www"].join("/etc/passwd")
