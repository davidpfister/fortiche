<a id="readme-top"></a>

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <h3 align="center">fortiche</h3>

  <p align="center">
    Fortran interfaces, classes and header extensions.
    <br />
    <a href="https://github.com/davidpfister/fortiche"><strong>Explore the project »</strong></a>
    <br />
  </p>
</div>

# Introduction
<!-- ABOUT THE PROJECT -->
## About the Project

> _fortiche_ (adjective and noun) 
> 
> who is strong or smart

Fortiche is a collection of various preprocessor macros designed to extend the current features of the fortran standard. It contains various experiments that have been collected over the years. 

This repo should be seen as an experimentation and was develop to test the limits of preprocessor macros. Fortran and preprocessing is kind of a love hate relationship. While preprocessing has never been standardized, you will find numerous projects that uses macros for various reasons going from reusability of the code, ersatz of generics, reduced verbosity of the code, etc. 

To cite Stroustrup’s book _The C++ Programming Language_

> The first rule about macros is: Don’t use them unless you have to. Almost every macro demonstrates a flaw in the programming language, in the program, or in the programmer.

So before you start having fun with macros just ask yourself if it increases the readability and the maintainability of the code.

|Folder|Description|
|:-----|:----------|
|[app](./src/app)|Introduces the _console_ keywords for build command line applications. It contains a simple argument parser and provides a fine control on the exit sequence. It also introduces the macros __COMPILER_NAME_ and __OS_NAME_|
|[array](./src/array)|Introduces the keywords _reallocate_, _reallocate_with_, _reallocate_as_ and _resize_ for allocatable arrays.|
|[assertion](./src/assertion)|'assertion' is a single-file, dependency-free, and simple micro framework for unit testing in fortran. The API is modeled after googletest|
|[contract](./src/contract)|Introduces the concept of **multiple** inheritance into fortran. In addition, one can define a _contract_ (abstract types without components) only containing _clause_ (i.e. defered procedures)|
|[export](./src/export)|Exports functions using DEC extension|
|[logging](./src/logging)|Introduces _info_, _warn_, _debug_, _error_ and _fatal_. This exemple is an beyond simple logging library. The logging level is controlled with the environment variable _LOGGING_LEVEL_|
|[logical](./src/logical)|Introduces short-circuiting logic to the language. In other words, in the block `if cond1() .and. cond2() then`, cond2() is not evaluated when cond1() returns false|
|[loop](./src/loop)|Introduces the _foreach_ construct together with _only()_ and _exclude()_ filters|
|[namelist](./src/namelist)|Introduces _serialize_ and _deserialize_ generic functions for derived type that can be written to namelists|
|[optional](./src/optional)|Introduces _optionalize_ to deal with optional parameters and reduce slightly the verbosity|


* [![fpm][fpm]][fpm-url]
* [![ifort][ifort]][ifort-url]
* [![gfortran][gfortran]][gfortran-url]

<!-- GETTING STARTED -->
## Getting Started

### Requirements

To build that library you need

- a Fortran 2008 compliant compiler, or better, a Fortran 2018 compliant compiler.

The following compilers are tested on the default branch of *fortiche*:
<center>

| Name |	Version	| Platform	| Architecture |
|:--:|:--:|:--:|:--:|
| GCC Fortran (MinGW) | 14 | Windows 10 | x86_64 |
| Intel oneAPI classic	| 2021.5	| Windows 10 |	x86_64 |

</center>
- a preprocessor. *fortiche* uses quite some preprocessor macros. It is known to work both with intel `fpp` an gcc `cpp`.  

### Installation

#### Get the code
```bash
git clone https://github.com/davidpfister/fortiche
cd fortiche
```

#### Build with fpm

Each subfolder contains a fpm projects. It can be build using *fpm*
For convenience, the  folder also contains a response file that can be invoked as follows: 
```
fpm @test
```

#### Build with Visual Studio 2019

The project was originally developed on Windows with Visual Studio 2019. The repo contains the solution file (_Fortiche.sln_) to get you started with Visual Studio 2019. 

<!-- USAGE EXAMPLES -->
## Usage

_For more examples, please refer to the test folders_

### Reporting a bug

A bug is a *demonstrable problem* caused by the code in this repository.
Good bug reports are extremely valuable to us—thank you!

Before opening a bug report:

1. Check if the issue has already been reported
   ([issues](https://github.com/davidpfister/fortiche/issues)).
2. Check if it is still an issue or it has been fixed?
   Try to reproduce it with the latest version from the default branch.
3. Isolate the problem and create a minimal test case.

A good bug report should include all information needed to reproduce the bug.
Please be as detailed as possible:

1. Which version of *fortiche* are you using? Please be specific.
2. What are the steps to reproduce the issue?
3. What is the expected outcome?
4. What happens instead?

This information will help the developers diagnose the issue quickly and with
minimal back-and-forth.

<!-- LICENSE -->
## License

Distributed under the MIT License.

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/davidpfister/fortiche.svg?style=for-the-badge
[contributors-url]: https://github.com/davidpfister/fortiche/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/davidpfister/fortiche.svg?style=for-the-badge
[forks-url]: https://github.com/davidpfister/fortiche/network/members
[stars-shield]: https://img.shields.io/github/stars/davidpfister/fortiche.svg?style=for-the-badge
[stars-url]: https://github.com/davidpfister/fortiche/stargazers
[issues-shield]: https://img.shields.io/github/issues/davidpfister/fortiche.svg?style=for-the-badge
[issues-url]: https://github.com/davidpfister/fortiche/issues
[license-shield]: https://img.shields.io/github/license/davidpfister/fortiche.svg?style=for-the-badge
[license-url]: https://github.com/davidpfister/fortiche/blob/master/LICENSE
[product-screenshot]: doc/images/screenshot.png
[gfortran]: https://img.shields.io/badge/gfortran-000000?style=for-the-badge&logo=gnu&logoColor=white
[gfortran-url]: https://gcc.gnu.org/wiki/GFortran
[ifort]: https://img.shields.io/badge/ifort-000000?style=for-the-badge&logo=Intel&logoColor=61DAFB
[ifort-url]: https://www.intel.com/content/www/us/en/developer/tools/oneapi/fortran-compiler.html
[fpm]: https://img.shields.io/badge/fpm-000000?style=for-the-badge&logo=Fortran&logoColor=734F96
[fpm-url]: https://fpm.fortran-lang.org/
