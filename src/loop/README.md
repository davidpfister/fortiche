# Loop

Introduces the _foreach_ construct together with _only()_ and _exclude()_ filters

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