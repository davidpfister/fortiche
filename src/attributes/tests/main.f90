#include "../include/attributes.inc"
program main
    implicit none

    call test()

    contains

    !obsolete(test)
    subroutine test()
        print*, "Don't call me."
    end subroutine
end program