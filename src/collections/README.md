# Collections

This is an attempt to create dynamic arrays of any type in a functional way. 

Dynamic lists exists for intrinsic types: 
- allocatable characters
- integers
- reals
- class(*)

List can simply declares as: 
```fortran
list(real(8)) :: l
```

Generic list can also be created, as
```fortran
list() :: l
```

The library contains the following methods
- `add`
- `clear`
- `get`
- `insert`
- `remove`
- `sizeof`

It also contains a template for creating lists of derived types (see `listof.inc`)
To use it, simply use a combination of `#define` and `#include` macros

```fortran
module string_list
    use string_m
    
    implicit none; private
    
#define T string
#include "../include/listof.inc"
#undef T

end module
```
## Building

This library uses [t4](https://github.com/mono/t4) as a templating engine. 

> T4 templates are a simple general-purpose way to use C# to generate any kind of text or code files.

That templating engine was quite popular in the .NET world before blazor and the inbuild code generation. While initially only working on Windows, it has been ported to other platform through the Mono project. It is now available from [Github](https://github.com/mono/t4) or as a dotnet tool.

To install it from your favorite terminal: 
```bash
dotnet tool install -g dotnet-t4
```

To build the intrinsic list 
```bash
t4 templates/list.tt -o src/list/intrinsic_list.f90
```
