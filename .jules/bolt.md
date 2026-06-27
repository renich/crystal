## 2024-05-24 - Avoid O(N^2) array inclusion checks in type_merge.cr
**Learning:** Checking `array.includes?(item)` in tight loops for maintaining unique collections in compiler paths like type merging introduces significant O(N^2) bottlenecks, especially for large arrays of types.
**Action:** Use a parallel `Set` to track membership in O(1) time while keeping the array for ordered insertion, but apply a conditional threshold (e.g. `objects.size > 15`) to avoid the allocation overhead of `Set` for small collections.
