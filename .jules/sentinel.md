## 2026-07-12 - Windows Path Traversal in StaticFileHandler
**Vulnerability:** StaticFileHandler allowed path traversal on Windows because it only checked for null bytes (`\0`), meaning backslashes (`\`) could bypass validation and traverse directories.
**Learning:** Checking for `\0` is insufficient on Windows. POSIX vs. Windows path validation logic differs fundamentally, so platform-specific checks via `{% if flag?(:win32) %}` are required.
**Prevention:** Always validate against platform-specific path separators (`/` and `\`) when serving static files, using Crystal's compile-time platform flags.
