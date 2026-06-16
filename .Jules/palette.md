## 2026-06-16 - Adding accessibility to Crystal Playground
**Learning:** Crystal Playground's web views use raw HTML with SVGs (like GitHub Octicons). They lack accessibility on icon-only links and need explicit `aria-label` on `a` tags, `aria-hidden="true"` on decorative `svg` children, and `alt=""` on wrapper `img`s to be accessible to screen readers.
**Action:** Consistently add `aria-label` to parent links and hide their decorative children with `aria-hidden="true"` or `alt=""` across UI.
