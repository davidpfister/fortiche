#include "../include/list.inc"
#include "../../assertion/include/assertion.inc"
module string_m
    implicit none; private

    type, public :: string
        character(:), allocatable :: chars
    end type

end module

TESTPROGRAM(main)

    TEST(test_string_list)
        use string_m
        use polymorphic_list

        type(string) :: output
        list() :: l

        call add(l, string('test'))
        call add(l, string('hello!'))
        call add(l, string('123'))

        output = l(2)

        EXPECT_STREQ(output%chars, 'hello!')
    END_TEST

    TEST(test_char_list)
        use intrinsic_list
        use iso_fortran_env

        character(1) :: output
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