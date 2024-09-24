#include "../include/namelist.inc"
module test_module
   
    implicit none

    type, public :: test_object
        integer,  public        :: maxcalls = 100000000     !< Maximum number of function calls
        integer,  public        :: csv_unit = 0             !< Integer designating the logical output unit for csv results. Null value corresponds to unset value
        real(8), public        :: mintime = 100.0_8       !< Minimum sampling time in ms to collect data
        real(8), public        :: maxtime = 100000.0_8    !< Maximum sampling time in ms to collect data
        real(8), public        :: overhead = 0.0_8        !< Time overhead corresponding to the surounding methods calls
        integer,  public        :: sampling_window = 20     !< Integer option to adjust the size of the sampling window
        real(8), public        :: ssd_threshold = 0.05_8  !<  Acceptance threshold for the steady-state detection
        logical, public         :: skip_prelude = .false.   !< Logical flag. If set to .true., only the benchmarking step will be performed
        integer,  public        :: count = 0            
        character(200), public  :: name = ''                !<  String name
    end type

    contains

    subroutine serialization(test_object)
        !automatically generated
    end subroutine

    subroutine deserialization(test_object)
        !automatically generated
    end subroutine
end module