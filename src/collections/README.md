# Collections

Attempt to create dynamic arrays of any type in a functional way. 
Dynamic lists exists for intrinsic types: 
- allocatable characters(:)
- integers
- reals

List can simply declares as: 
```
list(real(8)) :: l
```

Generic list can also be created, as
```
list() :: l
```

The library contains the following methods
- add
- clear
- get
- insert
- remove
- sizeof

It also contains a template for creating lists of derived types (see listof.inc)

## Building

This library uses t4 as a templating engine. 
To build the intrinsic list 
```
t4 templates/list.tt -o src/list/intrinsic_list.f90
```
