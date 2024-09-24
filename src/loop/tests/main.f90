#include "../include/loop.inc"
program main
    implicit none

    integer :: i
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
end program