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
#define MACRO_CAT2(A,B) A/**/_/**/B
#define MACRO_CAT3(A,B,C) MACRO_CAT2(A,B)/**/_/**/C
#define MACRO_CAT4(A,B,C,D) MACRO_CAT3(A,B,C)/**/_/**/D
#define MACRO_CAT5(A,B,C,D,E) MACRO_CAT4(A,B,C,D)/**/_/**/E
#define MACRO_STRINGIFY(A) "A"
#else
#define MACRO_CAT2(A,B) A##_##B
#define MACRO_CAT3(A,B,C) A##_##B##_##C
#define MACRO_CAT4(A,B,C,D) A##_##B##_##C##_##D
#define MACRO_CAT5(A,B,C,D,E) A##_##B##_##C##_##D##_##E
#define MACRO_STRINGIFY(A) #A
#endif
#define contract(name) type, abstract :: name; contains
#define contract_from(base, name) type, extends(base), abstract :: name; contains
#define endcontract end type
#define clause(itrf) procedure(itrf), deferred
#define implements(n) MACRO_CAT2(implements,n)
#define implements_1(c1) extends(c1)
#define implements_2(c1,c2) \
abstract, extends(c1) :: MACRO_CAT2(c1,c2);end type;type, extends(MACRO_CAT2(c1,c2))
#define implements_3(c1, c2, c3) \
abstract, extends(c1) :: MACRO_CAT2(c1,c2);end type;type, abstract, extends(MACRO_CAT2(c1,c2)) :: MACRO_CAT3(c1,c2,c3);end type;type, extends(MACRO_CONCAT3(c1,c2,c3))
#define implements_4(c1, c2, c3, c4) \
abstract, extends(c1) :: MACRO_CAT2(c1,c2);end type;type, abstract, extends(MACRO_CAT2(c1,c2)) :: MACRO_CAT3(c1,c2,c3);end type;type, abstract, extends(MACRO_CAT3(c1,c2,c3)) :: MACRO_CAT4(c1,c2,c3,c4);end type;type, extends(MACRO_CAT4(c1,c2,c3,c4))
#define implements_5(c1, c2, c3, c4, c5) \
abstract, extends(c1) :: MACRO_CAT2(c1,c2);end type;type, abstract, extends(MACRO_CAT2(c1,c2)) :: MACRO_CAT3(c1,c2,c3);end type;type, abstract, extends(MACRO_CAT3(c1,c2,c3)) :: MACRO_CAT4(c1,c2,c3,c4);end type;type, abstract, extends(MACRO_CAT4(c1,c2,c3,c4)) :: MACRO_CAT5(c1,c2,c3,c4,c5);end type;type, extends(MACRO_CAT5(c1,c2,c3,c4,c5))