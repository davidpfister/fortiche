#include "../include/app.inc"
#include "../include/os.inc"
#include "../include/compiler.inc"  
console(test)
    subroutine main(args)
        type(string), intent(in) :: args(:)
        integer :: i, nargs
        
        print*, app%location()
        
        call app%onexit(app, callme)
        
        nargs = size(args)
        print*, nargs
        
        do i = 1, nargs
            print *, args(i)%chars
        end do

        print*, _COMPILER_NAME
        print*, _OS_NAME
    end subroutine
            
    subroutine callme(context)
        class(*), intent(inout) :: context
        
        cast(context, application)
            print*, 'Exiting app from ' // context%username()
        endcast
    end subroutine
end