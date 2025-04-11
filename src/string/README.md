# String

Introduces string interpolation to the Fortran language. The interpolation works with any intrinsic types and 
derived types that extend the `writable` abstract type.

```fortran
#include "../include/string.inc"

    character(:), allocatable :: x, y, z, s

    x = 'world'
    y = 'universe'
    z = 'Hello'
        
    s = strf('{z} {x}, and {y}!',(x, y, z))
    !Prints 'Hello world, and universe!'
```