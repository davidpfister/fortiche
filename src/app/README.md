# App

Introduces the _console_ keywords for build command line applications. 

The _console_ replaces the _program_ keywords. The following function must be the subroutine _main_ and take as arguments the command line arguments. 

It contains a simple argument parser and also provides a fine control on the exit sequence by registering a callback function that is invoked before leaving.

```fortran

console(test)
    subroutine main(args)
        type(string), intent(in) :: args(:)
        !...
        call app%onexit(app, foo)

    end subroutine
            
    subroutine foo(context)
        class(*), intent(inout) :: context
        
        cast(context, application)
            print*, 'Exiting app from ' // context%username()
        endcast
    end subroutine
end
```