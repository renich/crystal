## 2024-05-18 - Accessible Icon-Only Links with Materialize CSS Tooltips
**Learning:** Materialize CSS tooltips (like `data-tooltip`) do not inherently provide an accessible name for screen readers for icon-only links and buttons. This means screen reader users may not know what the link or button does.
**Action:** Always add `aria-label` to the parent anchor or button, and add `aria-hidden="true"` to any purely decorative child SVGs or `alt=""` to purely decorative wrapper images.
