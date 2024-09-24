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
!
! This code was motivated by the following discussion
! https://fortran-lang.discourse.group/t/retrieve-compiler-info-at-run-time/8192/19
#ifdef _COMPILER_NAME
#undef _COMPILER_NAME
#endif
#ifdef __GFORTRAN__
#define _COMPILER_NAME "GCC"
#elif defined(__INTEL_COMPILER)
#if defined(__INTEL_LLVM_COMPILER)
#if defined (__linux__)
#define _COMPILER_NAME "IFX (NIX)"
#elif defined (WIN32) || defined (_WIN32) || defined (__WIN32__) || defined (__NT__)
#define _COMPILER_NAME "IFX (WINDOWS)"
#else
#define _COMPILER_NAME "IFX"
#endif
#else
#if defined (__linux__)
#define _COMPILER_NAME "IFORT (NIX)"
#elif defined (WIN32) || defined (_WIN32) || defined (__WIN32__) || defined (__NT__)
#define _COMPILER_NAME "IFORT (WINDOWS)"
#elif defined (__APPLE__)
#define _COMPILER_NAME "IFORT (MAC)"
#endif
#endif
#elif defined (NAGFOR)
#define _COMPILER_NAME "NAG"
#elif defined (__PGI)
#if defined (__NVCOMPILER]
#define _COMPILER_NAME "NVHPC"
#else
#define _COMPILER_NAME "PGI"
#endif
#elif defined (__NVCOMPILER)
#define _COMPILER_NAME "NVHPC"
#elif defined (_CRAYFTN)
#define _COMPILER_NAME "CRAYFTN"
#elif defined (__IBMC__]
#define _COMPILER_NAME "IBMXL"
#endif