require "uri"
require "path"
request_path = URI.decode("/%5c%2e%2e%5cetc%5cpasswd")
p request_path
if request_path.includes? '\\'
  p "bad_request"
end
