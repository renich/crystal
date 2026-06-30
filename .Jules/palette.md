## 2024-06-30 - Visual Tooltips Do Not Provide Accessible Names
**Learning:** Visual tooltips (like Materialize CSS `data-tooltip`) do not inherently provide an accessible name for screen readers on icon-only links/buttons.
**Action:** Always manually add `aria-label` to the parent anchor or button, and ensure purely decorative inner elements like SVGs have `aria-hidden="true"` or `alt=""`.
