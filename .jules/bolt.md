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

## 2024-07-15 - Optimizing Array#includes? lookups with Set tracking in Type Merging
**Learning:** When collecting unique items from lists using `Array#includes?` on every element (like in `type_merge.cr`'s `compact_types`), it introduces O(N^2) complexity. This becomes a bottleneck for larger arrays, significantly slowing down semantic analysis. However, blindly replacing Array with Set for all array sizes introduces constant allocation overhead that slows down the most common path (small arrays <= 15 items).

**Action:** Overload the recursive methods (`add_type` here) to optionally accept a `Set` for fast O(1) membership checks via `.add?`. In the caller (`compact_types`), branch based on input size: for small inputs (`<= 15`), stick to the basic Array and O(N) lookup. For larger inputs, initialize a `Set` alongside the `Array` to get the best of both worlds (1.4x faster for 100 items, 5.8x faster for 500 items).
