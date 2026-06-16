## 2024-05-24 - DoS and CSWSH via unhandled KeyError in WebSocket Header Lookup
**Vulnerability:** CSWSH/DoS via `Origin` header lookup in WebSocket handlers
**Learning:** Crystal's `HTTP::Headers#[]` strict lookup throws a `KeyError` if the header is missing. Unhandled exceptions in `HTTP::Server` worker fibers crash the server process, creating a Denial of Service vulnerability when an attacker connects without an `Origin` header.
**Prevention:** Always use safe accessors `headers["HeaderName"]?` for request headers when writing handlers, and ensure the resulting `String?` type is securely evaluated for access control.
