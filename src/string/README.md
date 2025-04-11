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

The parser supports interpolates variables by `name` or by `position`

```fortran
#include "../include/string.inc"

    character(:), allocatable :: x, y, z, s

    x = 'world'
    y = 'universe'
    z = 'Hello'
        
    s = strf('{3} {1}, and {2}!',(x, y, z))
    !Prints 'Hello world, and universe!'
```

In addition, a specific format can be given if needed: 
```fortran
#include "../include/string.inc"

    integer :: i = 42
    character(:), allocatable :: s
       
    s = strf('I love {i:i4}!',(i))
    !Prints 'I love 42!'
```