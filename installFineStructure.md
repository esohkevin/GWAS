fineStructure installation
---

A tool for haplotype-based Population Structure Analysis

`wget https://people.maths.bris.ac.uk/~madjl/finestructure/fs-2.1.3.tar.gz`

It reguires the following libraries (It will not work without the libraries)
---
- GNU Scientific Library (GSL, development version package libgsl0-dev and libgsl0 in Ubuntu, gsl-devel in OpenSUSE

   `sudo apt-get install libgsl0-dev`

   `sudo apt-get install gsl-devel`

- GCC c++ compiler (package build-essential in ubuntu)

   `sudo apt-get install build-essential`

- Switch.pm for perl

   `sudo apt-get install libswitch-perl`

Compilation
---
```	
   tar -xzvf fs-2.1.3.tar.gz

   cd fs-2.1.3/

   ./configure

   make

   sudo make install
```
