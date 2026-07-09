## 2024-05-19 - Accessible Labels for Crystal Playground

**Learning:** When evaluating Crystal Playground's user interface, several icon-only links and buttons completely lacked accessible names, making it difficult for screen-reader users to understand their purpose. Additionally, decorative SVGs were being read out unnecessarily. Adding ARIA labels and hiding the decorative elements via `aria-hidden` improves navigation significantly without affecting the visual layout.
**Action:** When creating or evaluating icon-only components across the UI, consistently apply `aria-label` to the interactive element, `aria-hidden="true"` to the decorative SVG inside, and verify image tags include an empty `alt=""` tag if they are purely decorative or their purpose is conveyed by the wrapper link.
