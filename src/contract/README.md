# Contract

Introduces the concept of <ins>multiple</ins> inheritance into Fortran. 

In addition, one can define a _contract_ (aka abstract types without components) only containing _clause_ (aka deferred procedures)

```fortran
contract(type1)
    clause(foo_x), pass(this) :: foo
endcontract

contract(type2)
    clause(bar_x), nopass :: bar
endcontract

abstract interface
    subroutine foo_x(this)
        import type1
        class(type1), intent(in) :: this
    end subroutine
    
    subroutine bar_x()
    end subroutine
end interface

type, implements(2)(type1,type2) :: mytype
    character(20) :: name
    contains
    procedure, pass(this) :: foo
    procedure, nopass :: bar
end type
```