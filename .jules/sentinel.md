# Sentinel Security Journal

This file contains CRITICAL security learnings only (e.g., unique vulnerability patterns, unexpected side effects).

## Entry Template
<!--
## YYYY-MM-DD - [Title] **Vulnerability:** [What you found] **Learning:** [Why it existed] **Prevention:** [How to avoid next time]
-->

## 2024-05-24 - StaticFileHandler Windows Path Traversal Bypass
**Vulnerability:** The HTTP `StaticFileHandler` explicitly blocked the NUL byte (`\0`) but missed checking for backslashes (`\`). On Windows (`win32`), both `/` and `\` act as directory separators, meaning an attacker could bypass directory traversal protections by using backslashes instead of standard slashes.
**Learning:** Crystal runs across POSIX and Windows. Fixes for path parsing must account for architecture-specific semantics. Rejecting `\` globally would break POSIX where `\` is a valid filename character, so the fix requires conditional compilation `{% if flag?(:win32) %}`.
**Prevention:** Always consider target-specific file system behaviors (Windows backslashes vs POSIX) when writing security validations for paths. Use compile-time flags to scope OS-specific sanitization rules.

## 2024-05-31 - [WebSocket Unhandled Exceptions DoS]
**Vulnerability:** The Crystal Playground WebSocket server endpoints would crash the fiber (DoS) if they received an invalid route missing digits (`Regex#match!`), a request missing an Origin header (`KeyError` from `headers["Origin"]`), or malformed JSON payloads (`JSON::ParseException` and `KeyError` from `JSON.parse` and `#as_s`).
**Learning:** Crystal's fiber model crashes entirely on unhandled exceptions in the request loop. Unsafe assertion methods (`match!`, direct Hash lookups `[]`, unprotected `.as_s` cast) are highly dangerous on untrusted inputs like headers and payload bodies.
**Prevention:** Always use safe accessors (`[]?`, `match`), rescue `JSON::ParseException`, and use safe casts (`.try(&.as_s?)`) when processing user data in web handlers.
## 2026-07-15 - Prevent Path Traversal in StaticFileHandler on Windows
**Vulnerability:** HTTP requests with backslashes on Windows could bypass path validation in StaticFileHandler.
**Learning:** Windows treats backslashes as directory separators. Standard POSIX path validation (checking for null bytes) is insufficient on Windows host systems.
**Prevention:** Apply explicit conditionally-compiled logic (`{% if flag?(:win32) %}`) to reject paths containing backslashes before they are expanded and served.
