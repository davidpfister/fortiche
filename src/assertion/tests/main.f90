module test_object_type
    implicit none

    type :: t_object
        integer :: i
        real :: x
    end type

    type :: t_other
        integer :: i
        real :: x
    end type

end module

#include "../include/assertion.inc"
TESTPROGRAM(main)

    TEST('string_tests')
        character(*), parameter :: s1 = 'TEST'
        character(:), allocatable :: s2
        
        s2 = 'test'

        EXPECT_STREQ(s1, 'TEST')
        EXPECT_STRNE(s1, s2)
        EXPECT_STRCASEEQ(s1, s2)

        ASSERT_STREQ(s1, 'TEST')
        ASSERT_STRNE(s1, s2)
        ASSERT_STRCASEEQ(s1, s2)
    END_TEST

    TEST('logical_tests')
        logical :: true = .true.
        logical :: false = .false.

        EXPECT_TRUE(true)
        EXPECT_FALSE(false)
        EXPECT_TRUE(.not. false)
        EXPECT_FALSE(.not. true)
        ASSERT_TRUE(true)
        ASSERT_FALSE(false)
        ASSERT_TRUE(.not. false)
        ASSERT_FALSE(.not. true)
        
    END_TEST

    TEST('equality_tests_for_types')
        use test_object_type

        type(t_object), allocatable, target :: obj1
        type(t_object), allocatable ::obj2
        type(t_other), allocatable :: obj3

        type(t_object), pointer :: ptr => null()

        obj1 = t_object(1, 0.5)
        obj2 = t_object(5, 1.25)
        obj3 = t_other(1, 0.5)

        EXPECT_BEQ(obj1, obj3)
        ASSERT_BEQ(obj1, obj3)
        EXPECT_BNEQ(obj1, obj2)
        ASSERT_BNEQ(obj1, obj2)

        EXPECT_NSAME(obj1, obj3)
        ASSERT_NSAME(obj1, obj3)

        obj2%i = 1
        obj2%x = 0.5

        EXPECT_NSAME(obj1, obj2)
        ASSERT_NSAME(obj1, obj2)

        ptr => obj1
        EXPECT_SAME(obj1, ptr)
        ASSERT_SAME(obj1, ptr)

        nullify(ptr)
    END_TEST

    TEST('inequality_tests')
        double precision, parameter :: r1 = 1.0d0
        double precision :: r2 = 1.0d0
        double precision :: r3 = 2.0d0

        EXPECT_EQ(r1, r2)
        ASSERT_EQ(r1, r2)

        EXPECT_NE(r1, r3)
        ASSERT_NE(r1, r3)

        EXPECT_LE(r1, r3)
        ASSERT_LE(r1, r3)
        EXPECT_LE(r1, r2)
        ASSERT_LE(r1, r2)

        EXPECT_LT(r1, r3)
        ASSERT_LT(r1, r3)

        EXPECT_GE(r3, r1)
        ASSERT_GE(r3, r1)
        EXPECT_GE(r1, r2)
        ASSERT_GE(r1, r2)

        EXPECT_GT(r3, r1)
        ASSERT_GT(r3, r1)
    END_TEST

    TEST('floating_point_tests')
        real, parameter :: e1 = 1.0e0
        real :: e2 = 1.0e0
        real :: e3 = 2.0e0

        double precision, parameter :: d1 = 1.0d0
        double precision :: d2 = 1.0d0
        double precision :: d3 = 2.0d0

        EXPECT_FLOAT_EQ(e1, e2)
        EXPECT_FLOAT_EQ(e1, e2 + 0.5*epsilon(e1))
        EXPECT_FLOAT_NE(e1, e3)
        ASSERT_FLOAT_EQ(e1, e2)
        ASSERT_FLOAT_EQ(e1, e2 + 0.5*epsilon(e1))
        ASSERT_FLOAT_NE(e1, e3)

        EXPECT_DOUBLE_EQ(d1, d2)
        EXPECT_DOUBLE_NE(d1, d2 + 0.5*epsilon(e1))
        EXPECT_DOUBLE_NE(d1, d3)
        ASSERT_DOUBLE_EQ(d1, d2)
        ASSERT_DOUBLE_NE(d1, d2 + 0.5*epsilon(e1))
        ASSERT_DOUBLE_NE(d1, d3)
    END_TEST

END_TESTPROGRAM