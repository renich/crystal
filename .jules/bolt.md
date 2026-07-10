## 2024-05-24 - Compiler Internal Performance: Type Merging
**Learning:** Standalone benchmark scripts attempting to require compiler internal files directly (like `src/compiler/crystal/semantic/type_merge.cr`) often fail to compile due to missing preludes or constants (e.g., `Annotatable`).
**Action:** When benchmarking internal compiler components, mock the core logic within the standalone script to isolate the algorithmic performance difference, then verify correctness by building the full compiler and running standard specifications (e.g., `make crystal` and `bin/crystal spec`).
