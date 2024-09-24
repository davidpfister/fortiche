#include "../include/namelist.inc"
program main
    use test_module
    implicit none

    type(test_object) :: o
    type(test_object) :: o2

    o%maxcalls = 10
    o%csv_unit = -10
    o%mintime = 50.0_8
    o%maxtime = 100.0_8
    o%sampling_window = 10
    o%ssd_threshold = 0.025_8

    call serialize(test_object)(o, 'namelist.nml')

    print*, o2%ssd_threshold
    call deserialize(test_object)(o2, 'namelist.nml')
    print*, o2%ssd_threshold
end program