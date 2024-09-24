#include "../include/array.inc"
program main
    implicit none

    real(8), allocatable :: array(:)
    real(8) :: source(15)
    real(8) :: mold(12)

    source = 1.0

    allocate(array(10))

    resize(real(8))(array, 20)

    !should print 20
    print*, size(array)

    reallocate_with(1)(array, source)

    !should print 15
    print*, size(array)

    reallocate(1)(array, 10)

    !should print 10
    print*, size(array)

    reallocate_as(1)(array, mold)

    !should print 12
    print*, size(array)
    
end program