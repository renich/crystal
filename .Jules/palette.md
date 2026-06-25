## 2026-06-25 - Materialize Tooltips & SVG Accessibility
**Learning:** Materialize CSS's `data-tooltip` attribute provides visual tooltips but does not expose an accessible name to screen readers. Furthermore, decorative inner SVGs in icon-only buttons need to be hidden from the accessibility tree to avoid confusion.
**Action:** Always complement `data-tooltip` on icon-only buttons with an explicit `aria-label`, and ensure the decorative child `<svg>` element has `aria-hidden="true"`.
