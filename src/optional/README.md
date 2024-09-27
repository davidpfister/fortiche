# Optional

Introduces _optionalize_ to deal with optional parameters. This one could somehow be obtained with a classical function (cf. optval in stdlib) but it requires writing the same function for any possible type. 

```fortran
function test(option) result(res)
    character(*), optional :: option
    !private
    character(:), allocatable :: res

    optionalize(res, option, 'Hello World!')

end function
```

The macro expands to the following 
```fortran
if (present(option)) then				
	res = option						
else									
	res = 'Hello World!'							
end if
```