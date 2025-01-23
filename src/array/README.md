# Array

Introduces the keywords `reallocate`, `reallocate_with`, `reallocate_as` and `resize` for allocatable arrays.

```fortran

    resize(kind)(array, dim)

    reallocate_with(rank)(array, source)

    reallocate(rank)(array, dim)

    reallocate_as(rank)(array, mold)
```