# Logical

Introduces short-circuiting logic to the language. In other words, in the block `if cond1() andalso cond2() then`, cond2() is not evaluated when cond1() returns `.false.`

> NOTE: This implementation present a strong limitation and should not be used when exiting existing do-loop since it wraps the `if` construct in a `block` construct. One good think of an extension with labeled loops.

```fortran

iff (cond1() andalso cond2()) then
    print*, 'hello!' 
endiff

iff (cond2() orelse cond1()) then
    print*, 'hello!'
endiff

```

