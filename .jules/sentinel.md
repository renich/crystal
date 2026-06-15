## 2024-05-24 - Unhandled Exceptions in Fiber Connection Handlers (DoS Risk)
**Vulnerability:** HTTP/WebSocket handlers raised unhandled exceptions (`KeyError` via missing `HTTP::Headers` or Hash keys, and `MatchError` via `match!`) when receiving malformed requests.
**Learning:** Crystal fibers running connection handlers will crash if an exception escapes. `[]` on Hashes and Headers, and `match!` on Regex, throw exceptions on failure. If user input controls these lookups, this is an unauthenticated DoS vulnerability.
**Prevention:** Always use safe access operators (`[]?`, `.match`) when handling data derived from user input or request parameters. Explicitly handle the `nil` case (e.g., closing connections or returning a 4xx HTTP status code).
