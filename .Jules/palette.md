## 2026-06-12 - Crystal Playground Icon-Only Buttons
**Learning:** Crystal Playground UI uses materialize.css tooltips (`data-tooltip`) to explain icon-only buttons. Screen readers don't always read these data attributes reliably. A common a11y pattern found in this app's components is missing structural accessibility for these elements.
**Action:** When working on icon-only interactive elements in the Playground (like links acting as buttons), always add a descriptive `aria-label` to the anchor tag itself, and hide the decorative/inner SVG icon using `aria-hidden="true"`.
