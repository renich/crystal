
## 2024-05-24 - CSWSH Vulnerability in Playground

**Vulnerability:** Crystal Playground exposed a CSWSH (Cross-Site WebSocket Hijacking) vulnerability allowing RCE when bound to `0.0.0.0` by unconditionally accepting all origins.
**Learning:** `0.0.0.0` wildcard binds are common for LAN testing but should not bypass origin checks entirely. Blindly validating `Origin` against `Host` globally weakens DNS Rebinding protections for `localhost` bindings.
**Prevention:** For `0.0.0.0` bindings, require exact `Origin` match with `Host` header. For `localhost` bindings, enforce strict string matching to maintain defense against DNS Rebinding.

## 2024-05-24 - Header KeyError DoS

**Vulnerability:** Unhandled `KeyError` on `context.request.headers["Origin"]`.
**Learning:** Crystal's `HTTP::Headers#[]` throws an exception if the key is missing, crashing the fiber and causing denial of service.
**Prevention:** Always use `[]?` to safely extract HTTP headers when their absence is a possibility.
