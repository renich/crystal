require "./src/http/headers"
h = HTTP::Headers.new
h["foo"] = "bar\r\nbaz: quux"
p h["foo"]
