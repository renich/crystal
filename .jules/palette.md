# Palette UX & Accessibility Journal

This file contains critical UX and accessibility learnings.

## Entry Template
<!--
## YYYY-MM-DD - [Title] **Learning:** [UX/a11y insight] **Action:** [How to apply next time]
-->
## 2024-05-18 - Improve accessibility in Playground web UI
**Learning:** Icon-only links and buttons do not provide accessible names for screen readers natively, and decorative SVGs should be hidden.
**Action:** Add `aria-label` to the parent anchor tags and `aria-hidden="true"` to decorative child SVGs or `alt=""` for decorative images to improve accessibility for icon-only components.
