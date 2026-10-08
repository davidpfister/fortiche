As scientific software grows beyond a few hundred lines, tests stop being optional. They become the only thing standing between confidence and superstition.

I wanted something that felt like GoogleTest. I also wanted something that felt like Fortran. So I wrote a tiny testing framework. It fits in a single header file. And it's built almost entirely from macros.

## Why another Fortran testing framework?

The obvious question is: why?

Fortran already has excellent testing frameworks. [pFUnit](https://github.com/Goddard-Fortran-Ecosystem/pFUnit) or [veggies](https://github.com/everythingfunctional/veggies), for example, brings rich functionality and modern testing workflows to large scientific projects.

But sometimes you don't want rich functionality.

Sometimes you want:

* zero dependencies,
* no build-system gymnastics,
* no generated code,
* no modules to install,
* no external executables,
* something you can drop into an existing codebase in under a minute.

I wanted a testing framework that you could understand by opening one file.

Not one directory. One file!

## The entire framework is a header

The framework lives in a single preprocessor include. Once included, you can write tests like this:

```fortran
TESTPROGRAM(test_math)

TEST("addition")

    EXPECT_EQ(2 + 2, 4)

    EXPECT_TRUE(10 > 3)

    EXPECT_FLOAT_EQ(0.1 + 0.2, 0.3)

END_TEST

END_TESTPROGRAM
```

The output looks familiar:

```text
[ RUN      ] addition. EXPECT_EQ at line 55
[       OK ] addition. EXPECT_EQ line 55
[ RUN      ] addition. EXPECT_TRUE at line 57
[       OK ] addition. EXPECT_TRUE line 57
[ RUN      ] addition. EXPECT_FLOAT_EQ at line 59
[       OK ] addition. EXPECT_FLOAT_EQ line 59
[----------] Ran 3 tests from addition
[  PASSED  ] 3 tests from addition
[==========] Ran 3 tests
[  PASSED  ] 3 tests
```

That resemblance to GoogleTest is entirely intentional. Good tools teach users what to expect.

The output format has already been refined by millions of developers over many years. There was no reason to reinvent it.

## The preprocessor is Fortran's secret metaprogramming language

The funniest part of this project is that almost none of it is "real" Fortran.

It's mostly this:

```fortran
#define EXPECT_EQ(val1, val2) \
START_BLOCK(EXPECT_EQ) \
if(val1 .eq. val2) then; \
END_BLOCK(val2, val1, .false., *)
```

Macros expand into blocks.

Blocks declare local variables.

Blocks measure execution time.

Blocks print colorful diagnostics.

Blocks count successes and failures.

By the time the compiler sees the source code, your elegant one-line assertion has become dozens of lines of ordinary Fortran.

No templates.

No reflection.

No compiler plugins.

Just the humble preprocessor doing surprisingly heavy lifting.

It feels slightly illegal.

Which means it's probably fun.

## EXPECT versus ASSERT

One of the first design choices I borrowed from GoogleTest was distinguishing between `EXPECT_*` and `ASSERT_*`.

An expectation records failure and keeps going:

```fortran
EXPECT_EQ(size(a), 10)
EXPECT_TRUE(allocated(buffer))
EXPECT_STREQ(name, "simulation")
```

You get the full picture of what failed.

An assertion stops immediately:

```fortran
ASSERT_TRUE(allocated(buffer))

! Only executed if the assertion succeeded
EXPECT_EQ(size(buffer), 100)
```

This distinction matters.

When debugging, I usually want as much information as possible.

But sometimes continuing execution after a failure simply doesn't make sense.

Having both modes turns out to be incredibly useful.

## More than equality

Once the infrastructure existed, the temptation to keep adding assertions became irresistible.

Eventually the framework accumulated support for:

### Boolean assertions

```fortran
EXPECT_TRUE(condition)
EXPECT_FALSE(condition)
```

### Numerical comparisons

```fortran
EXPECT_EQ(a, b)
EXPECT_NE(a, b)

EXPECT_LT(a, b)
EXPECT_LE(a, b)

EXPECT_GT(a, b)
EXPECT_GE(a, b)
```

### Floating-point comparisons

```fortran
EXPECT_FLOAT_EQ(a, b)
EXPECT_DOUBLE_EQ(a, b)

EXPECT_NEAR(a, b, tolerance)
```

Floating-point equality deserves special treatment.

Comparing real numbers bit-for-bit is often the wrong thing to do.

The framework instead uses machine spacing:

```fortran
2.0 * spacing(max(abs(a), abs(b)))
```

which behaves much more like what users expect.

### Strings

```fortran
EXPECT_STREQ(s1, s2)
EXPECT_STRCASEEQ(s1, s2)
```

Even case-insensitive comparisons made it into the single-header experiment.

### Identity and byte equality

These are probably my favorite oddities:

```fortran
EXPECT_SAME(a, b)
EXPECT_BEQ(a, b)
```

`EXPECT_SAME` checks whether two entities refer to the same object.

`EXPECT_BEQ` compares their raw memory representations using `TRANSFER`.

They're niche.

But scientific programmers occasionally need niche tools.

## The failure that taught me something

One of my favorite moments happened while testing the framework itself.

I had a string comparison that looked identical.

The output disagreed:

```text
EXPECT_STREQ (102) : error:

   Actual:
error: Error opening input file...

   Expected:
error: Error opening input file...
```

At first glance, the strings appeared identical.

But they weren't.

One contained an extra blank line.

The framework had done exactly what I wanted: it made a subtle difference impossible to ignore.

Good testing frameworks don't merely tell you that something failed.

They help you understand why.

## The beauty of tiny tools

There's a tendency in software engineering to equate sophistication with size.

More files.

More abstractions.

More dependencies.

More configuration.

Sometimes that's justified. Sometimes it isn't.

This project reminded me that useful tools can be astonishingly small.

A single header.

A collection of macros.

A few ANSI escape codes.

And suddenly an old Fortran codebase starts telling you stories:

```
[ RUN      ]
[       OK ]
[  FAILED  ]
[==========]
```

## Final thoughts

I don't think this framework will replace pFUnit. It isn't trying to. Instead, it occupies a different corner of the ecosystem. The "I just need tests" corner. The "I don't want another dependency" corner. The "I miss GoogleTest" corner.

Fortran has survived for nearly seventy years because it adapts remarkably well to new ideas while retaining its pragmatic core.

Modern testing practices shouldn't be an exception. If a single-header framework packed with macros can make testing a little easier—and maybe even a little enjoyable—then this tiny experiment has already exceeded my expectations.