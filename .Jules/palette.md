## 2024-07-13 - Playground Accessibility Improvements
**Learning:** Icon-only buttons and links in ECR templates (like `.brand-logo`, settings gear, and fixed action buttons) lack accessible names for screen readers, leading to poor accessibility in the Playground interface.
**Action:** Always add `aria-label` to the parent anchor tags and `aria-hidden="true"` (or `alt=""` for images) to purely decorative child SVG/IMG elements.
