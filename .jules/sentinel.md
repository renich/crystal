## 2024-05-31 - Path Traversal via Backslash on Windows
**Vulnerability:** Path traversal in `HTTP::StaticFileHandler` via mixed-slash payloads (`/..\..\`) on Windows environments.
**Learning:** Crystal's POSIX path expansion may not safely sanitize backslashes intended for Windows directory traversal, even after URL decoding. Path traversal protections must explicitly account for platform-specific path separators.
**Prevention:** Conditionally check for backslashes using `{% if flag?(:win32) %}` when validating URL paths for file systems on Windows.
