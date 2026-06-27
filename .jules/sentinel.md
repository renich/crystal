## 2024-05-18 - Unhandled Exceptions in Fiber Connection Handlers
**Vulnerability:** Application Denial of Service (DoS) due to unhandled exceptions in `WebSocketHandler` crashing the fiber.
**Learning:** In Crystal, accessing Hash keys with `[]` or using Regex `match!` throws exceptions (`KeyError`, `MatchError`) on failure. In fiber handlers, uncaught exceptions crash the process. The playground server was vulnerable to DoS if a client omitted the `Origin` header or sent an invalid `/agent` path.
**Prevention:** Always use safe accessors like `[]?` for Hash/HTTP Headers and `.match` for Regex when handling inputs in connection handlers, explicitly checking and handling `nil` returns.
