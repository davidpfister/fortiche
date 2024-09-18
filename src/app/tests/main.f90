#include <app.inc>    
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
    end subroutine
            
    subroutine callme(context)
        class(*), intent(inout) :: context
        
        cast(context, application)
            print*, context%username()
        endcast
    end subroutine
end