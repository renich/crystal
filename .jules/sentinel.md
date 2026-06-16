## 2024-06-16 - Unhandled Exceptions in Fiber Connection Handlers
**Vulnerability:** Use of `match!` on user-supplied paths, and `[]` on Hashes/Headers without existence checks in HTTP handlers.
**Learning:** In Crystal, unhandled exceptions in Fiber connection handlers cause a crash, leading to a Denial of Service (DoS). `[]` and `match!` raise exceptions if the key/match is missing.
**Prevention:** Always use safe accessors like `[]?` and `.match` and handle `nil` cases gracefully when dealing with external inputs.
