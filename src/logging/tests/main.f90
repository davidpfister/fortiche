#include "../include/logging.inc"
program test
    implicit none

    call environment_setvar("LOGGING_LEVEL", "2")
    !info should not show
    info('info')
    warn('warn')
    debug('debug')
    error('error')

    call environment_setvar("LOGGING_LEVEL", "1")
    !info should show
    info('info')
    warn('warn')
    debug('debug')
    error('error')
    
    contains

    subroutine environment_setvar(name, value, ierr)
        use iso_c_binding
        character(*), intent(in)        :: name
        character(*), intent(in)        :: value
        integer, intent(out), optional    :: ierr

        interface
#ifdef _WIN32
        integer(c_int) function putenv_c(name, value) bind(c, name='_putenv_s')
            import
            implicit none
            character(kind=c_char, len=1), intent(in) :: name(*)
            character(kind=c_char, len=1), intent(in) :: value(*)
        end function
#else
        integer(c_int) function setenv_c(name, value, overwrite) bind(c, name='setenv')
            import
            implicit none
            character(kind=c_char, len=1), intent(in) :: name(*)
            character(kind=c_char, len=1), intent(in) :: value(*)
            integer(c_int), value :: overwrite
        end function

        integer(c_int) function unsetenv_c(name) bind(c, name='unsetenv')
            import
            implicit none
            character(kind=c_char, len=1), intent(in) :: name(*)
        end function
#endif
    end interface

        !private
        integer(c_int) :: res, overwrite
        overwrite = 1
#ifdef _WIN32
        res = putenv_c(name//c_null_char, value//c_null_char)
#else
        res = setenv_c(name//c_null_char, value//c_null_char, overwrite)
#endif
        if (present(ierr)) ierr = res
    end subroutine

end program