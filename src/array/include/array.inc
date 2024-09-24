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
#define resize(T) block; \
T, allocatable :: temp(:); \
MACRO_CAT(resize_T)
#define resize_T_(array, n) integer :: na;\
na = size(array);\
allocate(temp(n));\
temp(:na) = array;\
call move_alloc(temp, array);\
end block
#define reallocate(dim) MACRO_CAT2(reallocate,dim)
#define reallocate_with(dim) MACRO_CAT2(reallocate_with,dim)
#define reallocate_as(dim) MACRO_CAT2(reallocate_as,dim)
#define reallocate_0(scalar) if (allocated(scalar)) deallocate(scalar); allocate(scalar)
#define reallocate_1(array, n1) if (allocated(array)) deallocate(array); allocate(array(n1))
#define reallocate_2(matrix, n1, n2) if (allocated(matrix)) deallocate(matrix); allocate(matrix(n1, n2))
#define reallocate_with_0(scalar, source) if (allocated(scalar)) deallocate(scalar); allocate(scalar, source = source)
#define reallocate_with_1(array, source) if (allocated(array)) deallocate(array); allocate(array(size(source, dim=1)), source = source)
#define reallocate_with_2(matrix, source) if (allocated(matrix)) deallocate(matrix); allocate(matrix(size(source, dim=1), size(source, dim=2)), source = source)
#define reallocate_as_0(scalar, mold) if (allocated(scalar)) deallocate(scalar); allocate(scalar, mold = mold)
#define reallocate_as_1(array, mold) if (allocated(array)) deallocate(array); allocate(array(size(mold, dim=1)), mold = mold)
#define reallocate_as_2(matrix, mold) if (allocated(matrix)) deallocate(matrix); allocate(matrix(size(mold, dim=1), size(mold, dim=2)), mold = mold)