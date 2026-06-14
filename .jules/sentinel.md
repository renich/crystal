## 2024-06-14 - HTTP Header KeyError DoS
**Vulnerability:** Unauthenticated Denial of Service (DoS) via missing HTTP headers causing `KeyError`.
**Learning:** Crystal's `HTTP::Headers#[]` raises a `KeyError` if the header is absent. When extracting optional headers like `Origin` or `Host`, direct access crashes the server process.
**Prevention:** Always use the safe navigation operator `[]?` (e.g., `request.headers["Origin"]?`) when extracting HTTP headers that might be omitted by malicious or malformed clients.
