## 2023-10-27 - Unhandled Exception DoS and CSWSH Risks
**Vulnerability:** Unhandled exceptions in Crystal fiber connections due to `match!` and missing header accesses without `[]?` (DoS).
**Learning:** In Crystal, `KeyError` or `Regex::MatchError` crashes a fiber without robust recovery, leading to denial-of-service risks in WebSocket handlers.
**Prevention:** Always use safe accessors `[]?` on collections and headers, and `.match` for regex operations with `nil` checks, to avoid process crashes. Also ensure programmatic clients handle `Origin` carefully or don't falsely require it where browsers are absent.
