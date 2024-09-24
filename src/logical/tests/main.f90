#include "../include/logical.inc"
program main

    !'both function called'
    print*, 'first test'
    if and(cond1(), not_(cond2())) then
        print*, 'hello!'
    end if

    !'both function called'
    print*, 'second test'
    iff (cond1() andalso cond2()) then
        print*, 'hello!' 
    endiff

    !'only cond2 is called'
    print*, 'third test'
    iff (cond2() orelse cond1()) then
        print*, 'hello!'
    endiff

    !'both are caller called'
    print*, 'fourth test'
    iff (cond1() orelse cond2()) then
        print*, 'hello!'
    endiff

    !'only cond2 called'
    print*, 'fifth test'
    iff (cond2() andalso cond1()) then
        print*, 'hello!'
    endiff
    
    contains 

    logical function cond1()
        print*, 'cond1'
        cond1 = .true.
    end function

    logical function cond2()
        print*, 'cond2'
        cond2 = .false.
    end function

end program