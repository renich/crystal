## 2024-05-24 - Optimizing type_merge array includes?

**Learning:** `includes?` array search inside the Type Merger (which checks array membership with `array << item unless array.includes?(item)`) exhibits O(n^2) scaling behaviour. However, since the elements track unique types and the array is often small, using a `Set(UInt64)` based on `type.object_id` for tracking adds unnecessary allocation and hash overhead below 15 elements. For more than 15 items, `Set(UInt64)` dramatically speeds up the merge (nearly 3x faster in benchmarks for 100 elements).

**Action:** Replace `includes?` logic with `Set(UInt64)#add?` only if the array size exceeds 15, via a size threshold condition. Also use `UInt64` (object id) instead of raw `Type` objects to optimize the hashing in sets for these types, as `Type`s use reference equality.
