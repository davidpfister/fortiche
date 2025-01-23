# App

Introduces the `console` keyword to easily build command-line-applications. 

The `console` replaces the `program` keyword. The following function <ins>must</ins> be the subroutine `main` and takes as argument an array of string corresponding to the command line arguments. It is much like the _C_ counterpart `int main(int argc, char *argv[])`

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