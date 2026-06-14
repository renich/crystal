## 2024-05-23 - Accessibility of icon-only links in Crystal Playground
**Learning:** Icon-only links and buttons in the Crystal Playground lack proper accessibility attributes like `aria-label` and `aria-hidden` for decorative child SVG elements, meaning screen readers cannot properly announce these interactive elements.
**Action:** Adding `aria-label` to the anchors and `aria-hidden="true"` to child SVGs or `alt=""` to child images significantly improves screen reader UX.
