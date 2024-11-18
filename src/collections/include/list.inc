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
#define MACRO_CAT2(A,B) A/**/B
#define MACRO_CAT3(A,B,C) MACRO_CAT2(A,B)/**/C
#define MACRO_CAT4(A,B,C,D) MACRO_CAT3(A,B,C)/**/D
#define MACRO_CAT5(A,B,C,D,E) MACRO_CAT4(A,B,C,D)/**/E
#define MACRO_STRINGIFY(A) "A"
#else
#define MACRO_CAT2(A,B) A##B
#define MACRO_CAT3(A,B,C) A##B##C
#define MACRO_CAT4(A,B,C,D) A##B##C##D
#define MACRO_CAT5(A,B,C,D,E) A##B##C##D##E
#define MACRO_STRINGIFY(A) #A
#endif
#define list(x) type(MACRO_CAT3(item,_,x)), dimension(:), allocatable
#define BUFFER_SIZE 256
