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
#define LOG_INTERNAL(level, msg, line, file) \
block;\
character(1) :: logging_level;\
integer :: ilevel;\
call get_environment_variable("LOGGING_LEVEL", logging_level);\
if (len_trim(logging_level) > 0) then;\
ilevel = iachar(logging_level) - 48;\
else;\
ilevel = 0;\
end if;\
if (ilevel <= level) then;\
write(*, *) msg, line, file;\
end if;\
end block
#define   info(msg)  LOG_INTERNAL(1, msg, '', '')
#define   debug(msg) LOG_INTERNAL(2, msg, '', '')
#define   warn(msg)  LOG_INTERNAL(3, msg, '', '')
#define   error(msg) LOG_INTERNAL(4, msg // ' at line ', __LINE__, ' in file' // __FILE__)
#define   fatal(msg) LOG_INTERNAL(5, msg // ' at line ', __LINE__, ' in file' // __FILE__);error stop 1