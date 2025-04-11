
program main
#include "../include/string.inc"
    
    implicit none

    character(:), allocatable :: res

    call test()
    
    contains

    subroutine test()
        !private
        character(:), allocatable :: x, y, z, s
        integer :: i
        
        i = 42
        x = 'world'; y = 'universe'; z = 'Hello'
        
        s = strf('{z} {x}, and {y}!',(x, y, z))
        !'Hello world, and universe'
        
        s = strf('{z} {x}, and {y}!',(x))
        !'{z} world, and {y}!'
        
        s = strf('{i:i4} is the answer to everything',(i))
        !'42 is the answer to everything'
        
        s = strf('{3} {2}, and {1}!',(x, y, z))
        !'Hello world, and universe'
        
        s = strf('{1:i4} is the answer to everything',(i))
        !'42 is the answer to everything'
        
        s = strf('{0} is the answer to everything',(i))
        !'{0} is the answer to everything'

    end subroutine
end program