## 2024-05-18 - Visual tooltips and icon-only buttons
**Learning:** Visual tooltips (like Materialize CSS`s `data-tooltip`) do not inherently provide an accessible name for screen readers. Icon-only buttons with these tooltips are still inaccessible.
**Action:** Always add `aria-label` to the parent anchor or button, and `aria-hidden="true"` to the decorative child SVG/image when creating or modifying icon-only interactive elements.
