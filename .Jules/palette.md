## 2024-05-18 - Missing ARIA Labels on Materialize Action Buttons
**Learning:** Icon-only action buttons in the Materialize CSS floating action button container (`.fixed-action-btn`) lacked accessible names. Decorative SVG icons inside these buttons were also exposed to screen readers.
**Action:** Always add `aria-label` to the `<a>` or `<button>` container, and explicitly set `aria-hidden="true"` on the interior `<svg>` elements to prevent redundant or confusing screen reader announcements.
