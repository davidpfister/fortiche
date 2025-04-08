# Attributes

Introduces the attribute `obsolete` to flag deprecated subroutine/function

```fortran
!obsolete(test)
subroutine test()
	print*, "Don't call me."
end subroutine
```

The compiler prints the following message to the output window
```text
Warning: Using subroutine "test" in (1) is deprecated
```