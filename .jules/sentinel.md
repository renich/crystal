## 2024-06-13 - Path Traversal in Playground Server
**Vulnerability:** Path traversal (Directory Traversal) vulnerability in `WorkbookHandler` of the Playground server. User input was interpolated directly into `Dir["playground/#{$1}.{md,html,cr}"]` without sanitization.
**Learning:** Even when using string interpolation for file globbing rather than direct file reads, unchecked user input can result in directory traversal attacks, permitting arbitrary files outside the expected directory to be enumerated or exposed.
**Prevention:** Always validate user-provided path components by strictly blocking `..` and null bytes (`\0`) or resolve the path fully and verify that it remains within the intended root directory.
