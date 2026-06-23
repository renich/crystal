## 2024-05-18 - Unhandled Exceptions in Fiber Handlers

**Vulnerability:** Unhandled exceptions (`KeyError` and `MatchError`) in WebSocket handlers could cause a Denial of Service (DoS) by crashing the server.
**Learning:** In Crystal, unhandled exceptions inside spawned fibers or HTTP/WebSocket handlers crash the application. Accessing elements from Hashes or Headers using `[]` and using `Regex#match!` raises exceptions on missing keys or non-matches.
**Prevention:** Always use safe access `[]?` and safe pattern matching `match` (without the bang `!`), and explicitly handle `nil` values in fiber connections and HTTP handlers to prevent crashes and ensure a graceful response (e.g. `ws.close`).
