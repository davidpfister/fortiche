# Logging

Introduces the keywords `info`, `warn`, `debug`, `error` and `fatal` into the Fortran language. 

The logging level is controlled with the environment variable `_LOGGING_LEVEL_`

Logging levels go from 1 (info) to 5 (fatal)

```bash
export LOGGING_LEVEL=2
```

```fortran
info('info')
warn('warn')
debug('debug')
error('error')
fatal('fatal')
```

The call to fatal will also invokes the intrinsic _error stop_