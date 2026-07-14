# Bolt Performance Journal

This file contains CRITICAL performance learnings only (e.g., unique bottlenecks, optimizations that didn't work).

## Entry Template
<!--
## YYYY-MM-DD - [Title]
**Learning:** [Insight]
**Action:** [How to apply next time]
-->

## 2024-06-25 - Object Identity for Set lookups in Compiler
**Learning:** When trying to optimize O(N^2) `.includes?` lookups on arrays of AST nodes or Types in the Crystal compiler, `Set(Type)` is slow and bloated due to hashing overhead of deep compiler structures. However, since `Type` uses reference equality via `object_id`, tracking them in O(1) time using `Set(UInt64)` with `type.object_id` provides a massive ~200x performance speedup.
**Action:** Whenever identifying O(N^2) bottlenecks dealing with collections of `Type` or `ASTNode` instances in the compiler, utilize a parallel `Set(UInt64)` storing `object_id` for fast membership checks instead of relying on `includes?` or `Set(Type)`. Also note that the Code Review AI may falsely flag `nil_type` in `type_merge.cr` as a hallucination, even though it's a legitimate method in `Program` defined in `program.cr`.

## 2024-05-24 - Compiler Internal Performance: Type Merging
**Learning:** Standalone benchmark scripts attempting to require compiler internal files directly (like `src/compiler/crystal/semantic/type_merge.cr`) often fail to compile due to missing preludes or constants (e.g., `Annotatable`).
**Action:** When benchmarking internal compiler components, mock the core logic within the standalone script to isolate the algorithmic performance difference, then verify correctness by building the full compiler and running standard specifications (e.g., `make crystal` and `bin/crystal spec`).

## 2024-05-24 - Optimize Type Merge Object Tracking

**Learning:** When adding unique elements to an array in hot paths like `type_merge` in the Crystal compiler, `includes?` results in O(N^2) complexity. Using a parallel `Set(UInt64)` based on `object_id` significantly improves performance for larger collections, changing lookup from O(N) to O(1). However, `Set` allocation has overhead, so a threshold (e.g., `objects.size > 15`) should be used to fall back to `includes?` for smaller arrays.
**Action:** Always prefer `Set(UInt64)` for tracking object membership in performance-critical loops when working with arrays larger than 15 elements, maintaining backwards compatibility via method overloading for external callers.
