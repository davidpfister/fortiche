# Assertion
`assertion.inc` is a single-file, dependency-free, and simple micro-framework for unit testing in Fortran.

## Getting Started
We recommend starting from the test cases present in this repository. 
They are good starting material to get familiar with the library.

```fortran
#include "../include/assertion.inc"
TESTPROGRAM(main)

    TEST(string_tests)
        character(*), parameter :: s1 = 'TEST'
        character(:), allocatable :: s2
        
        s2 = 'test'

        EXPECT_STREQ(s1, 'TEST')
        EXPECT_STRNE(s1, s2)
        EXPECT_STRCASEEQ(s1, s2)
    END_TEST
END_TESTPROGRAM
```

The output would look like this
```cmd
[==========] Running test cases from tests\\main.f90
[----------] Test string_tests
[ RUN      ] string_tests.EXPECT_STREQ at line  10
[       OK ] string_tests.EXPECT_STREQ line  10 ( 0.000E+00 ms)
[ RUN      ] string_tests.EXPECT_STRNE at line  11
[       OK ] string_tests.EXPECT_STRNE line  11 ( 0.000E+00 ms)
[ RUN      ] string_tests.EXPECT_STRCASEEQ at line  12
[       OK ] string_tests.EXPECT_STRCASEEQ line  12 ( 0.000E+00 ms)
[----------] Ran   3 tests from string_tests
[  PASSED  ]   3 tests from string_tests( 0.000E+00 ms total)
```

## Features
- Simple, single-file, dependency-free micro test framework
Adding the assertion into your test project is easy as pie. Simply include the file `assertion.inc` into your code. This can either be done by specifying the relative path to the file (e.g. `#include "../include/assertion.inc"`) or in the toml file by adding the folder in which the file assertion.inc stands, directly under `[library]`, i.e.`include-dir = "include"`
- Color output
- Modeled after the assertions available in GoogleTest \
It should contain enough assertions to get you started. More assertion can easily be added.
- Fatal and non fatal failures\
You can specify whether a test failure should be treated as fatal or non-fatal, allowing tests to continue running even if a failure occurs.

### Assertions
|Method|Details|
|:--|:--|
|{ASSERT/EXPECT}_TRUE(condition)|Tests that condition .eqv. .true.|
|{ASSERT/EXPECT}_FALSE(condition)|Tests that condition .eqv. .false.|
|{ASSERT/EXPECT}_EQ(v1, v2)|Tests that v1 == v2|
|{ASSERT/EXPECT}_NE(v1, v2)|Tests that v1 != v2|
|{ASSERT/EXPECT}_SAME(v1, v2)|Tests that v1 == v2|
|{ASSERT/EXPECT}_NSAME(v1, v2)|Tests that v1 != v2|
|{ASSERT/EXPECT}_EQV(v1, v2)|Tests that v1 == v2|
|{ASSERT/EXPECT}_NEQV(v1, v2)|Tests that v1 != v2|
|{ASSERT/EXPECT}_LT(v1, v2)|Tests that v1 < v2|
|{ASSERT/EXPECT}_LE(v1, v2)|Tests that v1 <= v2|
|{ASSERT/EXPECT}_GT(v1, v2)|Tests that v1 > v2|
|{ASSERT/EXPECT}_GE(v1, v2)|Tests that v1 >= v2|
|{ASSERT/EXPECT}_STREQ(s1, s2)|Tests that s1 == s2|
|{ASSERT/EXPECT}_STRNE(s1, s2)|Tests that s1 != s2|
|{ASSERT/EXPECT}_STRCASEEQ(s1, s2)|Tests that s1 == s2, ignoring case|
|{ASSERT/EXPECT}_STRCASENE(s1, s2)|Tests that s1 != s2, ignoring case|
|{ASSERT/EXPECT}_FLOAT_EQ(val1, val2)|Tests that two float values are almost equal.|
|{ASSERT/EXPECT}_DOUBLE_EQ(val1, val2)|Tests that two double values are almost equal.|
|{ASSERT/EXPECT}_FLOAT_NE(val1, val2)|Tests that two float values are almost equal.|
|{ASSERT/EXPECT}_DOUBLE_NE(val1, val2)|Tests that two double values are almost equal.
|{ASSERT/EXPECT}_NEAR(v1, v2, abs_error)|Tests that v1 and v2 are within the given distance to each other.|

The values must be compatible with built-in types, or you will get a compiler error.  By "compatible" we mean that the values can be compared by the respective operator.

ASSERT/EXPECT_SAME is an attempt to create a generic equality comparer that should work for any standard and any derived types. 

## Developers Corner
The library heavily relies on pre-processing (using cpp or fpp). 
In order to simplify the development of the single file `assertion.inc` we recommend to map the extension '.inc' with Fortran highlighting settings in VSCode. 
To do so, 

> `Ctrl`+`Shift`+`P` \
"Change Language Mode"\
"Configure File Association for .inc"\
and select `Modern Fortran`
 
to visualize the outcome of the preprocessing, the preprocessor can be invoked directly: 
cpp
```
cpp -E main.f90 -I../include > main.fpp
```

or with fpp 
```
fpp -I../include main.f90 > main.fpp
```