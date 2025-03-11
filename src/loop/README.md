# Loop

Introduces the `foreach` construct together with `only(x)` and `exclude(x)` filters

```fortran

integer :: array(20) = [(i, i = 1, 20, 1)]

foreach(x, array)
    print*, int(x)
endfor

foreach(x, array) exclude(mod(x, 2) /= 0)
    print*, int(x)
endfor

foreach(x, array) only(mod(x, 2) == 0)
    print*, int(x)
endfor

```

In this example, _x_ must not be defined. It will be used in a _associated_ construct once expanded. So you are free to pick any name.
