# bashtest
[![CI/CD](https://github.com/heitorpolidoro/bashtest/actions/workflows/ci_cd.yml/badge.svg)](https://github.com/heitorpolidoro/bashtest/actions/workflows/ci_cd.yml)
![GitHub last commit](https://img.shields.io/github/last-commit/heitorpolidoro/bashtest)
[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=heitorpolidoro_bashtest&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=heitorpolidoro_bashtest)

[![Latest](https://img.shields.io/github/release/heitorpolidoro/bashtest.svg?label=latest)](https://github.com/heitorpolidoro/bashtest/releases/latest)
![GitHub Release Date](https://img.shields.io/github/release-date/heitorpolidoro/bashtest)

![GitHub](https://img.shields.io/github/license/heitorpolidoro/bashtest)

Functions to make test bash/shell script easy

To use:
```shell
source <(curl -s https://raw.githubusercontent.com/heitorpolidoro/bashtest/master/bashtest.sh)
```

Available functions:
### `assert()`
```
Return true if 2 strings are equals or false otherwise printing the values, 
actual and expected, the file and the line the assert was called
ARGUMENTS:
  actual: The string you are checking
  expected: The string, or regex, you expected that match equals with actual
OUTPUTS:
  If the 2 string doesn't match, print the file, function name and line where the assert was called, and
the expected and actual parameters
RETURN:
  true if the 2 strings have a match, false otherwise
```
### `mock()`
```
Mock a command or a function printing the received parameters
ARGUMENTS:
  function_name: The of the function, or command, to mock
OUTPUTS:
  The parameters to the function
```
### `set_env()`
```
Set an environment variable to use only in the test case.
ARGUMENTS:
 name: The name of the environment variable
 value: The value of the variable
```
### `run_tests()`
```
Run all the functions starting with "test_"
OUTPUTS:
 The result of each test
RETURN:
 0 if all the tests results is "OK", 1 otherwise```
