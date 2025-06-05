#include "../include/app.inc"
#include "../include/os.inc"
#include "../include/compiler.inc"  
console(test)
    main(args)
        integer :: i, nargs
        
        print*, app%location()
        
        call app%onexit(app, callme)
        
        nargs = size(args)
        print*, nargs
        
        do i = 1, nargs
            print *, args(i)%chars
        end do

        call test_clp()

        print*, _COMPILER_NAME
        print*, _OS_NAME
    endmain
            
    subroutine callme(context)
        class(*), intent(inout) :: context
        
        cast(context, application)
            print*, 'Exiting app from ' // context%username()
        endcast
    end subroutine

    subroutine test_clp()
        character(:), allocatable :: cl
        type(string), allocatable :: args(:)
        integer :: i
        
        cl = '"abc" d e'
        args = split_commandline_into_args(cl)
        write(*, *) args

        cl = 'a\\b d"e f"g h'
        args = split_commandline_into_args(cl)
        write(*, *) args

        cl = 'a\\\"b c d'
        args = split_commandline_into_args(cl)
        write(*, *) args

        cl = 'a\\\\"b c" d e'
        args = split_commandline_into_args(cl)
        write(*, *) args
        
        cl = 'a"b"" c d'
        args = split_commandline_into_args(cl)
        write(*, *) args
        
        cl = '--d "test\"'
        args = split_commandline_into_args(cl)
        write(*, *) args
        
        cl = '-d "a, b, c"'
        args = split_commandline_into_args(cl)
        write(*, *) args
        
        cl = """test path"" -d ""a, b, c"""
        args = split_commandline_into_args(cl)
        write(*, *) args
        
        cl = """test path"" -d 'a, b, c'"
        args = split_commandline_into_args(cl)
        write(*, *) args

    end subroutine
end