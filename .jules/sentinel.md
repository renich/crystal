## 2024-05-24 - Unhandled Exception (KeyError) on Missing Headers
**Vulnerability:** The Crystal Playground WebSocket handler accessed the "Origin" HTTP header using `context.request.headers["Origin"]` without checking if it existed.
**Learning:** If an HTTP header is not present and accessed using `[]`, Crystal raises a `KeyError`. This unhandled exception crashes the fiber processing the request, creating a Denial of Service (DoS) risk.
**Prevention:** Always use safe accessors like `[]?` (e.g., `context.request.headers["Origin"]?`) when handling headers derived from client requests to prevent unexpected crashes on missing data.
