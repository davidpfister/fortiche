# 1 "./tests\main.f90"
# 1 "./tests\../include\contract.inc" 1 
! All rights reserved.
!
! Redistribution and use in source and binary forms, with or without
! modification, are permitted provided that the following conditions are
! met:
!
!  Redistributions of source code must retain the above copyright
! notice, this list of conditions and the following disclaimer.
!   Redistributions in binary form must reproduce the above
! copyright notice, this list of conditions and the following disclaimer
! in the documentation and/or other materials provided with the
! distribution.
!   Neither the name of original developer, nor the names of its
! contributors may be used to endorse or promote products derived from
! this software without specific prior written permission.
!
! THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
! "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
! LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
! A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
! OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
! SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
! LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
! DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
! THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
! (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
! OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
# 34













# 48

# 50

# 52

# 54
# 2 "./tests\main.f90" 2 
module inheritance_test
    implicit none; private

    type, abstract :: file_handle; contains
        procedure(open_file), deferred, pass(handle) :: open
    end type

    type, abstract :: dummy; contains
        procedure(void), deferred, nopass :: foo
    end type

    abstract interface
        subroutine open_file(handle)
            import file_handle
            class(file_handle), intent(in) :: handle
        end subroutine
        
        subroutine void()
        end subroutine
    end interface

    type, abstract, extends(dummy) :: dummy_file_handle;end type;type, extends(dummy_file_handle), public :: mytype
    contains
        procedure, pass(handle) :: open
        procedure, nopass :: foo
    end type

    contains

    subroutine open(handle)
        class(mytype) :: handle

        print*, 'Calling open()'
    end subroutine

    subroutine foo()
        print*, 'Calling foo()'
    end subroutine
end module

program main
    use inheritance_test

    implicit none

    type(mytype) :: t

    call t%open()
    call t%foo()

    
end program
