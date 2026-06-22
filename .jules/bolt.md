## 2024-05-24 - Avoid O(N^2) Array Includes in Compiler Paths
**Learning:** In performance-critical paths of the Crystal compiler (like semantic analysis or type merging), using `array << item unless array.includes?(item)` causes O(N^2) complexity, leading to performance bottlenecks when collecting large sets of types.
**Action:** Use a parallel `Set` to track membership in O(1) time while maintaining the array for ordered insertion.
