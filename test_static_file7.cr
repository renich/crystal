require "uri"
require "path"

path = URI.decode("/%5c%2e%2e%5cetc%5cpasswd")
if path.includes? '\\'
  puts "backslash found"
end
