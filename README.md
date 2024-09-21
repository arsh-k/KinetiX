[![License](https://img.shields.io/badge/License-BSD%202--Clause-orange.svg)](https://opensource.org/licenses/BSD-2-Clause)

# KinetiX
A software toolkit for generating CPU and GPU code to compute chemical kinetics, thermodynamics, 
and transport properties from a chemical reaction mechanism.

## kinetix python package 

### Requirements
* Python v3.8 and later

Download or clone the repository.

### Local installation (optional)
Using the downloaded source code, kinetix can be installed as a Python module:
```sh
python3 install . 
```

### Usage
#### If locally installed
```sh
python3 -m kinetix --mechanism kinetix/mechanisms/gri30.yaml --output kinetix/out/mechanisms/gri
```

#### Standalone usage
```sh
python3 kinetix/__main__.py --mechanism kinetix/mechanisms/gri30.yaml --output kinetix/out/mechanisms/gri
```

## Benchmark kernels

Benchmark kernels are provided to evaluate the performance of the routines generated by kinetix for different computing platforms. 
These kernels use the [OCCA](https://github.com/libocca/occa) library to support various hardware targets such as CPUs (SERIAL backend) and GPUs (CUDA or HIP backend).

### Requirements:
#### Minimum
* Linux, Mac OS X (Microsoft Windows is not supported)
* C++17/C99 compatible compilers + GNU/Intel Fortran
* MPI-3.1 or later
* CMake version 3.21 or later
#### Optional
* CUDA 9 or later 
* HIP 4.2 or later
* SYCL 2020 or later
* Cantera 2.5 or later

### Installation:

To install the benchmark kernels, use the provided setup script:

```sh
cd benchmark
./install_bk.sh
```

For custom installation options, such as changing the installation directory or changing the amrex backend, run:
```sh
./install_bk.sh --help
```

### BK1: Species Production Rates
```sh
export OCCA_CXX=mpic++
mpirun -np 1 ${KINETIX_PATH}/bin/kinetix_bk --backend SERIAL --n-states 1000000 --mode 1 --yaml-file kinetix/mechanisms/gri30.yaml
```
```sh
mpirun -np 1 ${KINETIX_PATH}/bin/kinetix_bk --backend CUDA --n-states 1000000 --mode 1 --yaml-file kinetix/mechanisms/gri30.yaml
```

### BK2: Mixture-Averaged Transport Properties
```sh
export OCCA_CXX=mpic++
mpirun -np 1 ${KINETIX_PATH}/bin/kinetix_bk --backend SERIAL --n-states 1000000 --mode 2  --yaml-file kinetix/mechanisms/gri30.yaml
```
```sh
mpirun -np 1 ${KINETIX_PATH}/bin/kinetix_bk --backend CUDA --n-states 1000000 --mode 2  --yaml-file kinetix/mechanisms/gri30.yaml
```

## Examples

Check the `examples/` directory to see how the generated routines by KinetiX (or [PelePhysics](https://github.com/AMReX-Combustion/PelePhysics) or [Cantera](https://github.com/Cantera/cantera)) 
can be integrated in a simple MPI program without OCCA dependency (CPU only).

## License

KinetiX is licensed under the BSD-2 Clause License - see the [LICENSE](LICENSE) file for details.
