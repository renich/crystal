## 2024-06-16 - Directory Traversal via OS-Specific Path Parsing

**Vulnerability:** Directory traversal on Windows hosts via `HTTP::StaticFileHandler`. Request paths with URL-encoded or raw backslashes (`\`, `%5C`) bypassed POSIX-based path checking/expansion, but were then passed to Windows native path joining which interpreted them as directory separators, allowing escape from `public_dir`.

**Learning:** When expanding HTTP request paths across OS boundaries, always normalize separators early and explicitly reject paths containing `\` as it is never a valid separator in URLs, but may be mapped to one by native filesystem APIs (like `Path::Kind.native`). The translation between POSIX paths (for URLs) and native paths (for the file system) created a bypass.

**Prevention:** Reject requests containing backslashes in the `check_request_path!` handler before any `Path.posix` expansion occurs.
