module polymorphic_item
    implicit none; private

    public :: item_

    type item_
        class(*), allocatable :: content
    contains
        procedure, pass(rhs), private :: assign_item
        generic, public :: assignment(=) => assign_item
    end type

contains

    subroutine assign_item(lhs, rhs)
        use iso_c_binding
        class(*), intent(inout)   ::  lhs
        class(item_), intent(in)   ::  rhs
        interface
            subroutine memcpy(dest, src, n) bind(C, name='memcpy')
                import
                integer(c_intptr_t), value, intent(in) :: dest
                integer(c_intptr_t), value, intent(in) :: src
                integer(c_size_t), value :: n
            end subroutine
        end interface

        select type (lhs)
        class is (item_)
            lhs%content = rhs%content
        class default
            select type (x => rhs%content)
            class default
                call memcpy(loc(lhs), loc(x), storage_size(x, kind=c_size_t)/8_c_size_t)
            end select
        end select
    end subroutine
end module
