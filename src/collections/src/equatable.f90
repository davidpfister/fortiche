module polymorphic_equatable
    implicit none; private

    type, abstract, public :: equatable
    contains
        private
        procedure(equatable_to_any), pass(lhs), deferred, private :: equatable_eq_any
        procedure(equatable_to_any), pass(lhs), deferred, private :: equatable_neq_any
        procedure(any_to_equatable), pass(rhs), deferred, private :: any_eq_equatable
        procedure(any_to_equatable), pass(rhs), deferred, private :: any_neq_equatable
        generic, public :: operator(==) => equatable_eq_any, any_eq_equatable
        generic, public :: operator(/=) => equatable_neq_any, any_neq_equatable
    end type

    interface
        logical function equatable_to_any(lhs, rhs)
            import
            class(equatable), intent(in) :: lhs
            class(*), intent(in) :: rhs
        end function

        logical function any_to_equatable(lhs, rhs)
            import
            class(*), intent(in) :: lhs
            class(equatable), intent(in) :: rhs
        end function
    end interface

end module
