#include "../include/list.inc"

module string_m
    implicit none; private

    type, public :: string
        private
        character(:), allocatable :: chars
    contains
        procedure, pass(lhs), private :: equal_string
        generic, public :: operator(==) => equal_string
        procedure, pass(this), private :: write_string
        generic, public :: write(FORMATTED) => write_string
    end type
    
    interface string
        module procedure :: string_new
    end interface
    
    contains
    
    type(string) function string_new(chars) result(that)
        character(*), intent(in)    :: chars
        
        that%chars = chars
    end function
    
    logical function equal_string(lhs, rhs) result(res)
       class(string), intent(in)    ::  lhs
       character(*), intent(in)     ::  rhs
        
       res = lhs%chars == rhs
    end function
    
    subroutine write_string(this, unit, iotype, v_list, iostat, iomsg)
        class(string), intent(in)   :: this
        integer, intent(in)         :: unit
        character(*), intent(in)    :: iotype
        integer, intent(in)         :: v_list(:)
        integer, intent(out)        :: iostat
        character(*), intent(inout) :: iomsg

        write(unit, *, iostat=iostat) this%chars
    end subroutine

end module
    
module string_list
    use string_m
    
    implicit none; private
    
#define T string
#include "../include/listof.inc"
#undef T

end module
    
#include "../../assertion/include/assertion.inc"
TESTPROGRAM(main)

    TEST(test_string_list)
        use string_list

        type(string) :: output
        list(string) :: l

        call add(l, string('test'))
        call add(l, string('hello!'))
        call add(l, string('123'))

        output = l(2)

        EXPECT_STREQ(output, 'hello!')
    END_TEST

    TEST(test_integer_list)
        use intrinsic_list

        integer :: output
        list(integer(int32)) :: l

        call add(l, 1)
        call add(l, 2)
        call add(l, 3)

        output = l(2)

        call clear(l)

        EXPECT_EQ(sizeof(l), 0)
        EXPECT_EQ(output, 2)
    END_TEST

    TEST(test_char_list)
        use intrinsic_list

        character(:), allocatable :: output
        list(character) :: l

        call add(l, 'a')
        call add(l, 'b')
        call add(l, 'c')

        output = l(2)

        call clear(l)

        EXPECT_EQ(sizeof(l), 0)
        EXPECT_STREQ(output, 'b')
    END_TEST

    TEST(test_polymorphic_list)
        use polymorphic_list

        real(8) :: output
        list() :: l

        call add(l, 1.0d0)
        call add(l, [5.0d0, 25.0d0, 32.0d0])
        call insert(l, 2, 3.25d0)
        output = l(4)

        EXPECT_EQ(output, 25.0d0)
    END_TEST
END_TESTPROGRAM