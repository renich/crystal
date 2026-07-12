# Palette UX & Accessibility Journal

This file contains critical UX and accessibility learnings.

## Entry Template
<!--
## YYYY-MM-DD - [Title] **Learning:** [UX/a11y insight] **Action:** [How to apply next time]
-->
## 2024-07-12 - Explicit Context Verification for Complex UI Elements
**Learning:** When planning UI accessibility changes, do not blindly assume code structure based on partial snippets or context clues. Elements like `aria-label` targets or layout specific `id`s must be explicitly verified to exist in the exact file using complete output reads or precise `grep` before writing the plan.
**Action:** Always fully explore the HTML structure to find all interactive links, icons, and attributes to accurately construct a valid Git merge block or modification plan.

## 2024-07-12 - Granular Frontend Verification Steps
**Learning:** Frontend UI verification involving compilation, native specs, local server booting, Playwright scripts, and artifact cleaning encompasses too many distinct tool calls for a single step.
**Action:** Always break complex frontend verification into multiple atomic steps (e.g., Recompile, Verify UI with Script, Run Native Spec).
