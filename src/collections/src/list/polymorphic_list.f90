#include <list.inc>
module polymorphic_list
    use iso_fortran_env, only: character_storage_size
    use polymorphic_item, only: item_

    implicit none; private

    public :: item_, &
              add, &
              get, &
              insert, &
              clear, &
              remove, &
              sizeof

    interface add
        module procedure :: add_item
        module procedure :: add_range
    end interface

    interface clear
        module procedure  :: clear_item
    end interface

    interface get
        module procedure  :: get_item
    end interface

    interface insert
        module procedure :: insert_item
    end interface

    interface remove
        module procedure :: remove_item
    end interface

    interface sizeof
        module procedure  :: size_item
    end interface

contains

    subroutine add_to(vec, val, n, chunk_size, finished)
        type(item_), allocatable, intent(inout) :: vec(:)
        class(*), intent(in)                    :: val
        integer, intent(inout)                  :: n
        integer, intent(in)                     :: chunk_size
        logical, intent(in)                     :: finished
        !private
        type(item_), allocatable :: tmp(:)
        integer :: csize
        csize = chunk_size

        if (finished) csize = 1
        if (allocated(vec)) then
            if (n == size(vec)) then
                ! have to add another chunk:
                allocate (tmp(size(vec) + csize))
                tmp(1:size(vec)) = vec
                call move_alloc(tmp, vec)
            end if
            n = n + 1
        else
            ! the first element:
            allocate (vec(csize))
            n = 1
        end if

#ifdef __GFORTRAN__
        allocate (vec(n)%content, source=val)
#else
        vec(n) = item_(val)
#endif
        if (finished) then
            if (allocated(tmp)) deallocate (tmp)
            if (n /= size(vec)) then
                allocate (tmp(n), source=vec(1:n))
                call move_alloc(tmp, vec)
            end if
        end if
    end subroutine

    subroutine add_item(this, arg)
        type(item_), intent(inout), allocatable  :: this(:)
        class(*), intent(in)                     :: arg
        !private
        integer :: count
        count = size(this)
        call add_to(this, arg, count, BUFFER_SIZE, finished=.true.)
    end subroutine

    subroutine add_range(this, args)
        type(item_), intent(inout), allocatable  :: this(:)
        class(*), intent(in)                     :: args(:)
        !private
        integer :: i, n, count

        n = size(args)
        count = size(this)
        do i = 1, n
            call add_to(this, args(i), count, BUFFER_SIZE, finished=i == n)
        end do
    end subroutine

    subroutine clear_item(this)
        class(item_), intent(inout), allocatable :: this(:)

        if (allocated(this)) deallocate (this)
        allocate (this(0))
    end subroutine

    function get_item(this, key) result(res)
        class(item_), intent(inout) :: this(:)
        integer, intent(in) :: key
        type(item_), allocatable :: res
        !private
        integer :: n
        n = sizeof(this)

        if (key > 0 .and. key <= n) then
            res = this(key)
        end if
    end function

    subroutine insert_item(this, i, arg)
        type(item_), intent(inout), allocatable  :: this(:)
        integer, intent(in)                      :: i
        class(*), intent(in)                     :: arg
        !private
        integer :: j, count

        count = size(this)
        call add_to(this, arg, count, BUFFER_SIZE, finished=.true.)

        do j = count, i + 1, -1
            this(j) = this(j - 1)
        end do
#ifdef __GFORTRAN__
        if (allocated(this(i)%content)) deallocate (this(i)%content)
        allocate (this(i)%content, source=arg)
#else
        this(i) = item_(arg)
#endif
    end subroutine

    integer function size_item(this) result(res)
        type(item_), intent(inout), allocatable  :: this(:)
        if (.not. allocated(this)) then
            res = 0
        else
            res = size(this)
        end if
    end function

    subroutine remove_item(this, i)
        type(item_), intent(inout), allocatable  :: this(:)
        integer, intent(in)                      :: i
        !private
        type(item_), allocatable :: tmp(:)
        integer :: j, n

        n = size(this)

        do j = i, n - 1
            this(j) = this(j + 1)
        end do

        allocate (tmp(n - 1), source=this(1:n - 1))
        call move_alloc(tmp, this)
    end subroutine
end module
