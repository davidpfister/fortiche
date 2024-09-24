#include "../include/optional.inc"
program main
    implicit none

    character(:), allocatable :: res

    res = test()
    print*, res

    res = test('If Machiavelli were a hacker, he"d have worked for the CSSG.')
    print*, res

    contains

    function test(option) result(res)
        character(*), optional :: option
        !private
        character(:), allocatable :: res

        optionalize(res, option, 'Hello World!')

    end function
end program