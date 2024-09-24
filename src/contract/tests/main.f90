#include "../include/contract.inc"
module inheritance_test
    implicit none; private

    contract(file_handle)
        clause(open_file), pass(handle) :: open
    endcontract

    contract(dummy)
        clause(void), nopass :: foo
    endcontract

    abstract interface
        subroutine open_file(handle)
            import file_handle
            class(file_handle), intent(in) :: handle
        end subroutine
        
        subroutine void()
        end subroutine
    end interface

    type, implements(2)(dummy,file_handle), public :: mytype
    contains
        procedure, pass(handle) :: open
        procedure, nopass :: foo
    end type

    contains

    subroutine open(handle)
        class(mytype) :: handle

        print*, 'Calling open()'
    end subroutine

    subroutine foo()
        print*, 'Calling foo()'
    end subroutine
end module

program main
    use inheritance_test

    implicit none

    type(mytype) :: t

    call t%open()
    call t%foo()

    
end program