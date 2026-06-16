## 2024-06-12 - Path Traversal in Glob Patterns
**Vulnerability:** Path traversal in `Dir` glob patterns due to unsanitized capture groups.
**Learning:** In Crystal, `Dir["directory/#{unsanitized_input}"]` allows directory traversal. Even though `Dir[]` resolves paths, if the interpolation evaluates to a string containing `..` (e.g. `../../../etc/passwd`), `Dir[]` will successfully escape the base directory and return matching files from other parts of the filesystem.
**Prevention:** Always validate and sanitize user input before passing it into file system methods like `Dir[]`, `File.read`, etc. Specifically, check for or reject directory traversal sequences (`..`) and null bytes (`\0`).
