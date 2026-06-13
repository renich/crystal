## 2024-05-24 - Unhandled Exception DoS via Strict HTTP Header Lookup
**Vulnerability:** The playground WebSocket server would crash unhandled when a client omitted the `Origin` HTTP header, due to a strict dictionary lookup (`headers["Origin"]`).
**Learning:** Crystal's `HTTP::Headers#[]` strictly enforces the presence of the key, raising a `KeyError` and crashing the caller if the header is absent.
**Prevention:** Always use the nilable lookup method `headers["Origin"]?` when fetching user-controlled or optional HTTP headers, and handle the resulting `nil` securely.
