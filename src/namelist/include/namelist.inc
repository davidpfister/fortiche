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
#ifdef __GFORTRAN__
#define MACRO_CAT(A) A/**/_
#define MACRO_CAT2(A,B) A/**/_/**/B
#else
#define MACRO_CAT(A) A##_
#define MACRO_CAT2(A,B) A##_##B
#endif
#define serialize(T) MACRO_CAT2(serialize,T)
#define serialization(T) MACRO_CAT2(serialize,T)(this, path); \
class(T), intent(in), target :: this; \
character(*), intent(in) :: path;\
type(T), pointer :: MACRO_CAT(T) => null(); \
namelist / output / MACRO_CAT(T);\
integer :: ios, lu;\
open (newunit=lu, file=trim(path), delim='apostrophe', iostat = ios);\
if (ios == 0) then;\
MACRO_CAT(T) => this;\
write(unit=lu, nml=output);\
nullify(MACRO_CAT(T));\
close(lu);\
end if
#define deserialize(T) MACRO_CAT2(deserialize,T)
#define deserialization(T) MACRO_CAT2(deserialize,T)(this, path); \
type(T), intent(out) :: this; \
character(*), intent(in) :: path;\
type(T) :: MACRO_CAT(T); \
character(len=1000) :: line;\
integer :: ierr, lu, ios;\
logical :: exists;\
namelist / output / MACRO_CAT(T);\
inquire(file=trim(path), exist = exists);\
if (exists) then;\
open (newunit=lu, file=trim(path), status='old', action='read', delim='apostrophe', iostat = ios);\
if (ios == 0) then;\
read(nml=output, unit=lu, iostat=ierr);\
if (ierr /= 0) then;\
backspace(lu);\
read(lu, '(A)') line;\
write(*, '(A)') 'Invalid namelist at line '//trim(line);\
end if;\
this = MACRO_CAT(T);\
end if;\
end if
