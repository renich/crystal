## 2024-06-26 - Materialize Tooltips Missing ARIA Labels
**Learning:** Materialize CSS tooltips (`data-tooltip`) do not inherently provide an accessible name for screen readers on icon-only links/buttons.
**Action:** Always explicitly add `aria-label` to the parent anchor and `aria-hidden="true"` to the decorative child SVG when using tooltips on icon-only elements.
