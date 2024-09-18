#!/bin/bash -x
#SBATCH --job-name=nekRK_GPU
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --gres=gpu:1
#SBATCH --partition=booster
#SBATCH --account=dems
#SBATCH --time=08:00:00
#SBATCH --cpus-per-task=12
#SBATCH --output=mpi-out.%j
#SBATCH --error=mpi-err.%j
#SBATCH --distribution=block:block:fcyclic

# -------
# 936 GPU compute nodes
# 4× NVIDIA A100 GPUs
# -------

ulimit -s unlimited
##############

#LiDryer
rm -rf .cache/
srun ../bin/nekrk_bk --backend CUDA --n-states 1000000 --n-repetitions 100 --mode 0 --yaml-file ../mechanisms/LiDryer.yaml --fit-rcpDiffCoeffs
rm -rf .cache/
srun ../bin/nekrk_bk --backend CUDA --n-states 1000000 --n-repetitions 100 --mode 0 --yaml-file ../mechanisms/LiDryer.yaml --fit-rcpDiffCoeffs --nonsymDij
rm -rf .cache/
srun ../bin/nekrk_bk --backend CUDA --n-states 1000000 --n-repetitions 100 --mode 0 --yaml-file ../mechanisms/LiDryer.yaml --unroll-loops --fit-rcpDiffCoeffs
rm -rf .cache/
srun ../bin/nekrk_bk --backend CUDA --n-states 1000000 --n-repetitions 100 --mode 0 --yaml-file ../mechanisms/LiDryer.yaml --unroll-loops --loop-gibbsexp --fit-rcpDiffCoeffs --nonsymDij
rm -rf .cache/
srun ../bin/nekrk_bk --backend CUDA --n-states 1000000 --n-repetitions 100 --mode 0 --yaml-file ../mechanisms/LiDryer.yaml --unroll-loops --loop-gibbsexp --group-rxnUnroll --fit-rcpDiffCoeffs --nonsymDij --group-vis
rm -rf .cache/
srun ../bin/nekrk_bk --backend CUDA --n-states 1000000 --n-repetitions 100 --mode 0 --yaml-file ../mechanisms/LiDryer.yaml --tool Pele

#gri30 
rm -rf .cache/
srun ../bin/nekrk_bk --backend CUDA --n-states 1000000 --n-repetitions 100 --mode 0 --yaml-file ../mechanisms/gri30.yaml --fit-rcpDiffCoeffs
rm -rf .cache/
srun ../bin/nekrk_bk --backend CUDA --n-states 1000000 --n-repetitions 100 --mode 0 --yaml-file ../mechanisms/gri30.yaml --fit-rcpDiffCoeffs --nonsymDij
rm -rf .cache/
srun ../bin/nekrk_bk --backend CUDA --n-states 1000000 --n-repetitions 100 --mode 0 --yaml-file ../mechanisms/gri30.yaml --unroll-loops --fit-rcpDiffCoeffs
rm -rf .cache/
srun ../bin/nekrk_bk --backend CUDA --n-states 1000000 --n-repetitions 100 --mode 0 --yaml-file ../mechanisms/gri30.yaml --unroll-loops --loop-gibbsexp --fit-rcpDiffCoeffs --nonsymDij
rm -rf .cache/
srun ../bin/nekrk_bk --backend CUDA --n-states 1000000 --n-repetitions 100 --mode 0 --yaml-file ../mechanisms/gri30.yaml --unroll-loops --loop-gibbsexp --group-rxnUnroll --fit-rcpDiffCoeffs --nonsymDij --group-vis
rm -rf .cache/
srun ../bin/nekrk_bk --backend CUDA --n-states 1000000 --n-repetitions 100 --mode 0 --yaml-file ../mechanisms/gri30.yaml --tool Pele

#Konnov
rm -rf .cache/
srun ../bin/nekrk_bk --backend CUDA --n-states 1000000 --n-repetitions 40 --mode 0 --yaml-file ../mechanisms/EtOHKonnov.yaml --fit-rcpDiffCoeffs
rm -rf .cache/
srun ../bin/nekrk_bk --backend CUDA --n-states 1000000 --n-repetitions 40 --mode 0 --yaml-file ../mechanisms/EtOHKonnov.yaml --fit-rcpDiffCoeffs --nonsymDij
rm -rf .cache/
srun ../bin/nekrk_bk --backend CUDA --n-states 1000000 --n-repetitions 40 --mode 0 --yaml-file ../mechanisms/EtOHKonnov.yaml --unroll-loops --fit-rcpDiffCoeffs
rm -rf .cache/
srun ../bin/nekrk_bk --backend CUDA --n-states 1000000 --n-repetitions 40 --mode 0 --yaml-file ../mechanisms/EtOHKonnov.yaml --unroll-loops --loop-gibbsexp --fit-rcpDiffCoeffs --nonsymDij
rm -rf .cache/
srun ../bin/nekrk_bk --backend CUDA --n-states 1000000 --n-repetitions 40 --mode 0 --yaml-file ../mechanisms/EtOHKonnov.yaml --unroll-loops --loop-gibbsexp --group-rxnUnroll --fit-rcpDiffCoeffs --nonsymDij --group-vis
rm -rf .cache/
srun ../bin/nekrk_bk --backend CUDA --n-states 1000000 --n-repetitions 40 --mode 0 --yaml-file ../mechanisms/EtOHKonnov.yaml --tool Pele
