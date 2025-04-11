
program main
#include "../include/string.inc"
    
    implicit none

    character(:), allocatable :: res

    call test()
    
    contains

    subroutine test()
        !private
        character(:), allocatable :: x, y, z, s

        x = 'world'
        y = 'universe'
        z = 'Hello'
        
        s = strf('{z} {x}, and {y}!',(x, y, z))
        s = strf('{z} {x}, and {y}!',(x))

    end subroutine
end program