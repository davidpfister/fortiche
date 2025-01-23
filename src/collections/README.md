# Collections

This is an attempt to create dynamic arrays of any type in a functional way. 

Dynamic lists exists for intrinsic types: 
- allocatable characters(:)
- integers
- reals
and unlimited polymorphic arguments
- class(*)

List can simply declares as: 
```
list(real(8)) :: l
```

Generic list can also be created, as
```
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

## Building

This library uses [t4](https://github.com/mono/t4) as a templating engine. 

> T4 templates are a simple general-purpose way to use C# to generate any kind of text or code files.

That templating engine was quite popular in the .NET world before blazor and the inbuild code generation. While initially only working on Windows, it has been ported to other platform through the Mono project. It is now available from [Github](https://github.com/mono/t4) or as a dotnet tool.

To install it from your favorite terminal: 
```cmd
dotnet tool install -g dotnet-t4
```

To build the intrinsic list 
```
t4 templates/list.tt -o src/list/intrinsic_list.f90
```
