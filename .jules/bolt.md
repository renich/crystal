## 2024-06-25 - Object Identity for Set lookups in Compiler

**Learning:** When trying to optimize O(N^2) `.includes?` lookups on arrays of AST nodes or Types in the Crystal compiler, `Set(Type)` is slow and bloated due to hashing overhead of deep compiler structures. However, since `Type` uses reference equality via `object_id`, tracking them in O(1) time using `Set(UInt64)` with `type.object_id` provides a massive ~200x performance speedup.

**Action:** Whenever identifying O(N^2) bottlenecks dealing with collections of `Type` or `ASTNode` instances in the compiler, utilize a parallel `Set(UInt64)` storing `object_id` for fast membership checks instead of relying on `includes?` or `Set(Type)`. Also note that the Code Review AI may falsely flag `nil_type` in `type_merge.cr` as a hallucination, even though it's a legitimate method in `Program` defined in `program.cr`.
