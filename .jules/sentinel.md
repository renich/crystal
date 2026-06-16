## 2024-05-18 - Path Traversal via Backslashes

**Vulnerability:** Path traversal possible in `HTTP::StaticFileHandler` via backslashes (e.g., `..\..\`) when the application runs on Windows environments.
**Learning:** `Path.posix` expansion treats backslashes as regular filename characters, not path separators. When this posix path is later cast to `Path::Kind.native` on Windows, the backslashes are re-interpreted as path separators, allowing directory traversal.
**Prevention:** Explicitly reject incoming HTTP request paths that contain backslashes (`\`) before any path normalization or expansion occurs.
