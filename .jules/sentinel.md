## 2024-06-21 - Path Traversal via Backslashes in StaticFileHandler
**Vulnerability:** StaticFileHandler does not reject backslashes in request paths. This allows path traversal on Windows because Path.posix treats backslashes as literal characters during expansion, but the underlying Windows filesystem treats them as directory separators.
**Learning:** Cross-platform path validation must consider all possible directory separators, even when normalizing via POSIX.
**Prevention:** Explicitly reject backslashes (`\\`) in URLs for static files, as URLs should only use forward slashes (`/`).
