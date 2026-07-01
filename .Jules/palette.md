## 2026-07-01 - Visual tooltips do not provide accessible names
**Learning:** Materialize CSS's `data-tooltip` attribute (or similar visual-only tooltips) does not inherently provide an accessible name for screen readers. Icon-only links and buttons relying on these tooltips will be announced simply as "link" or "button" without context.
**Action:** Always add explicit `aria-label` attributes to icon-only links/buttons, and add `aria-hidden="true"` to the decorative inner SVGs or `alt=""` to decorative inner images to ensure a proper accessibility experience.
