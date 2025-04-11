module string_writable
    use, intrinsic :: iso_fortran_env
    
    implicit none; private

    public :: string_interpolate, &
              string_get_args,    &
              writable
    
    type, abstract :: writable
    contains
        private
        procedure(write_formatted), pass(dtv), deferred, private :: writable_write_formatted
        procedure(write_unformatted), pass(dtv), deferred, private :: writable_write_unformatted
        generic, public :: write (formatted)  => writable_write_formatted
        generic, public :: write (unformatted)=> writable_write_unformatted
    end type
    
    interface
        subroutine write_formatted(dtv, unit, iotype, v_list, iostat, iomsg)
            import writable
            class(writable), intent(in) :: dtv !< The string.
            integer, intent(in)         :: unit !< Logical unit.
            character(*), intent(in)    :: iotype !< Edit descriptor.
            integer, intent(in)         :: v_list(:) !< Edit descriptor list.
            integer, intent(out)        :: iostat !< IO status code.
            character(*), intent(inout) :: iomsg !< IO status message.
        end subroutine
        subroutine write_unformatted(dtv, unit, iostat, iomsg)
          import writable
          class(writable), intent(in)   :: dtv !! The string.
          integer, intent(in)           :: unit !! Logical unit.
          integer, intent(out)          :: iostat !! IO status code.
          character(*), intent(inout)   :: iomsg !! IO status message.
        end subroutine
    end interface

    type :: string_arg
        character(:), allocatable   :: key
        class(*), pointer           :: value => null()
    end type

    type(string_arg), allocatable :: args_(:)

    interface string_get_args
        module procedure :: string_get_args1,   &
                            string_get_args2,   &
                            string_get_args3,   &
                            string_get_args4,   &
                            string_get_args5,   &
                            string_get_args6,   &
                            string_get_args7
        end interface

    contains

    function string_interpolate(str, names, values) result(res)
        character(*), intent(in)        :: str, names
        type(string_arg), intent(in)    :: values(:)
        character(:), allocatable :: res
        !private
        character(:), allocatable :: cnames
        integer :: i, j, n, istart, istop
        integer, allocatable :: pos(:)
        type(string_arg), allocatable :: args(:)
        logical :: found
        
        cnames = trim(adjustl(names))
        n = len_trim(cnames)

        cnames = cnames(2:n-1)
        allocate(pos(0))
        
        i = 0
        do while (i < n)
            j = index(cnames(i+1:), ',')
            i = i + j
            if (j /= 0) then
                pos = [pos, i]
            else
                exit
            end if
        end do

        allocate(args, source = values)
        n = size(args)
        
        if (size(pos) + 1 /= n) then
            error stop 'The number of arguments do not match.'
        end if

        do i = 1, n
            if (i == 1) then
                if (n == 1) then
                    args(i)%key = trim(adjustl(cnames))
                else
                    args(i)%key = trim(adjustl(cnames(:pos(i)-1)))
                end if
            else if (i == n) then
                args(i)%key = trim(adjustl(cnames(pos(i-1)+1:)))
            else
                args(i)%key = trim(adjustl(cnames(pos(i-1)+1:pos(i)-1)))
            end if
        end do
        i = 1
        istop = 0
        res = ''
        do while (i <= len(str))
            if (str(i:i) == '{') then
                istart = i
                if (istop+1 /= istart)  res = res // str(istop+1:istart-1)
            else if (str(i:i) == '}') then
                istop = i
                found = .false.
                do j = 1, n
                    if (args(j)%key == str(istart+1:istop-1)) then
                        res = res // stringify(args(j)%value)
                        found = .true.
                        exit
                    end if
                end do
                if (.not. found) then
                    res = res // str(istart:istop)
                end if
            end if
            i = i + 1
        end do
        res = res // str(istop+1:)

        do i = 1, n
            nullify(args(i)%value)
            if (allocated(args(i)%key)) deallocate(args(i)%key)
        end do
        deallocate(args)
        
        contains

        function stringify(x) result(s)
            class(*), intent(in)        :: x
            character(:), allocatable   :: s
            
            allocate(character(4096) :: s)

            select type(x)
            type is (integer(int8));     write(s,'(i0)') x
            type is (integer(int16));    write(s,'(i0)') x
            type is (integer(int32));    write(s,'(i0)') x
            type is (integer(int64));    write(s,'(i0)') x
            type is (real(real32));      write(s,'(1pg0)') x
            type is (real(real64));      write(s,'(1pg0)') x
#ifdef HAS_REAL128
            type is (real(real128));     write(s,'(1pg0)') x
#endif
            type is (logical);           write(s,'(l1)') x
            type is (character(*));      write(s,'(a)') trim(x)
            type is (complex);           write(s,'("(",1pg0,",",1pg0,")")') x
            class is (writable)
                write(s,*) x
            end select
            s = trim(s)
        end function
    end function
    
    function string_get_args1(a1) result(res)
        class(*), intent(in), target    :: a1
        type(string_arg), allocatable   :: res(:)

        allocate(res(1))
        res(1)%value => a1
    end function

    function string_get_args2(a1, a2) result(res)
        class(*), intent(in), target    :: a1
        class(*), intent(in), target    :: a2
        type(string_arg), allocatable   :: res(:)
        
        allocate(res(2))
        res(1)%value => a1
        res(2)%value => a2
    end function

    function string_get_args3(a1, a2, a3) result(res)
        class(*), intent(in), target    :: a1
        class(*), intent(in), target    :: a2
        class(*), intent(in), target    :: a3
        type(string_arg), allocatable   :: res(:)

        allocate(res(3))
        res(1)%value => a1
        res(2)%value => a2
        res(3)%value => a3
    end function

    function string_get_args4(a1, a2, a3, a4) result(res)
        class(*), intent(in), target    :: a1
        class(*), intent(in), target    :: a2
        class(*), intent(in), target    :: a3
        class(*), intent(in), target    :: a4
        type(string_arg), allocatable   :: res(:)

        allocate(res(4))
        res(1)%value => a1
        res(2)%value => a2
        res(3)%value => a3
        res(4)%value => a4
    end function

    function string_get_args5(a1, a2, a3, a4, a5) result(res)
        class(*), intent(in), target    :: a1
        class(*), intent(in), target    :: a2
        class(*), intent(in), target    :: a3
        class(*), intent(in), target    :: a4
        class(*), intent(in), target    :: a5
        type(string_arg), allocatable   :: res(:)

        allocate(res(5))
        res(1)%value => a1
        res(2)%value => a2
        res(3)%value => a3
        res(4)%value => a4
        res(5)%value => a5
    end function

    function string_get_args6(a1, a2, a3, a4, a5, a6) result(res)
        class(*), intent(in), target    :: a1
        class(*), intent(in), target    :: a2
        class(*), intent(in), target    :: a3
        class(*), intent(in), target    :: a4
        class(*), intent(in), target    :: a5
        class(*), intent(in), target    :: a6
        type(string_arg), allocatable   :: res(:)

        allocate(res(6))
        res(1)%value => a1
        res(2)%value => a2
        res(3)%value => a3
        res(4)%value => a4
        res(5)%value => a5
        res(6)%value => a6
    end function

    function string_get_args7(a1, a2, a3, a4, a5, a6, a7) result(res)
        class(*), intent(in), target    :: a1
        class(*), intent(in), target    :: a2
        class(*), intent(in), target    :: a3
        class(*), intent(in), target    :: a4
        class(*), intent(in), target    :: a5
        class(*), intent(in), target    :: a6
        class(*), intent(in), target    :: a7
        type(string_arg), allocatable   :: res(:)

        allocate(res(7))
        res(1)%value => a1
        res(2)%value => a2
        res(3)%value => a3
        res(4)%value => a4
        res(5)%value => a5
        res(6)%value => a6
        res(7)%value => a7
    end function
end module