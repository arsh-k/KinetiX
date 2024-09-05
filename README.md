[![License](https://img.shields.io/badge/License-BSD%202--Clause-orange.svg)](https://opensource.org/licenses/BSD-2-Clause)

# Introduction
Generation of reaction kinetics, thermodynamics and transport properties kernels

## How to build

Requirements:
* Linux, Mac OS X (Microsoft Windows is not supported)
* C++17/C99 compatible compilers + GNU/Intel Fortran
* MPI-3.1 or later
* CMake version 3.21 or later
* Python v3.8 and later
* (CUDA, HIP, DPCPP, Cantera)

Installation:

```sh
mkdir build; cd build
cmake [-DCMAKE_INSTALL_PREFIX=$NEKRK_PATH] [-DAMReX_GPU_BACKEND=CUDA] [-DAMReX_PRECISION=SINGLE] ..
make -j4 install
```
## Generator standalone usage 

```sh
python3 generator/generate.py --mechanism mechanisms/gri30.yaml --output out/mechanisms/gri
```

## Benchmark Kernels

### BK1: Species Production Rates

```sh
> mpirun -np 1 bin/nekrk_bk --backend CUDA --n-states 1000000 --mode 1 --yaml-file mechanisms/gri30.yaml
```

### BK2: Mixture-Averaged Transport Properties

```sh
> mpirun -np 1 bin/nekrk_bk --backend CUDA --n-states 1000000 --mode 2  --yaml-file mechanisms/gri30.yaml
```
